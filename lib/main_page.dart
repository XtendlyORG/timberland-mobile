// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

import 'core/configs/environment_configs.dart';
import 'core/constants/navbar_configs.dart';
import 'core/presentation/widgets/bottom_navbar.dart';
import 'core/presentation/widgets/decorated_safe_area.dart';
import 'core/presentation/widgets/timberland_appbar.dart';
import 'core/presentation/widgets/timberland_container.dart';
import 'core/router/routes.dart';
import 'dashboard/presentation/pages/profile_page.dart';
import 'dashboard/presentation/widgets/dashboard.dart';
import 'features/app_infos/presentation/pages/trail_rules.dart';
import 'features/booking/presentation/pages/booking_page.dart';
import 'features/trail/presentation/pages/trail_directory.dart';

class MainPage extends StatefulWidget {
  final int selectedTabIndex;
  const MainPage({
    Key? key,
    required this.selectedTabIndex,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int currentIndex;
  late PageController pageController;

  final serviceLocator = GetIt.instance;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedTabIndex;
    pageController = PageController(
      initialPage: currentIndex,
      keepPage: true,
    );
  }

  Future<bool?> verifyToken(Dio dioClient, EnvironmentConfig environmentConfig) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    var refreshToken = await storage.read(key: 'refreshToken');
    log('OLD TOKEN: $token');
    log('OLD REFRESH TOKEN: $refreshToken');
    final response = await dioClient.post(
      '${environmentConfig.apihost}/members/accessToken/refresh',
      data: {'refreshCode': refreshToken},
    );
    log("REFRESH TOKEN HAS BEEN REFRESHED");

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('NEW TOKEN: ${response.data['token']}');
      log('NEW REFRESH TOKEN: ${response.data['refreshCode']}');

      if (response.data['token'] != null) {
        await storage.write(key: 'token', value: response.data['token']);
      } else {
        await storage.write(key: 'token', value: response.data['accessToken']);
      }
      await storage.write(key: 'refreshToken', value: response.data['refreshCode']);
      return true;
    } else {
      //logout
      final Session session = Session();
      session.logout();
      BlocProvider.of<AuthBloc>(context).add(const LogoutEvent());
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex != widget.selectedTabIndex) {
      currentIndex = widget.selectedTabIndex;
      pageController.jumpToPage(
        currentIndex,
      );
    }

    return FutureBuilder(
        future: verifyToken(serviceLocator(), serviceLocator()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) {
                if (current is UserGuideFinished) {
                  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                    context.goNamed(Routes.booking.name);
                  });
                }
                return current is! UnAuthenticated;
              },
              builder: (context, state) {
                if (state is UnAuthenticated && Session().isLoggedIn) {
                  Future.delayed(Duration.zero, () {
                    BlocProvider.of<AuthBloc>(context).add(
                      const FetchUserEvent(),
                    );
                  });
                }
                if (state is Authenticated) {
                  if (state.firstTimeUser) {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      context.goNamed(Routes.onboarding.name);
                    });
                    return const Scaffold();
                  }

                  return WillPopScope(
                    onWillPop: () async {
                      MoveToBackground.moveTaskToBack();
                      return false;
                    },
                    child: DecoratedSafeArea(
                      child: Scaffold(
                        endDrawer: currentIndex == 3 ? null : const Dashboard(),
                        appBar: TimberlandAppbar(
                          showEndDrawerButton: currentIndex == 3 ? false : true,
                        ),
                        extendBodyBehindAppBar: true,
                        bottomNavigationBar: BottomNavBar(
                          index: currentIndex,
                          configs: navbarConfigs,
                          onTap: (index) {
                            pageController.jumpToPage(
                              index,
                            );
                          },
                        ),
                        body: TimberlandContainer(
                          child: RepaintBoundary(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SizedBox(
                                  height: constraints.maxHeight,
                                  child: PageView(
                                    controller: pageController,
                                    onPageChanged: (index) {
                                      // dismis keyboard
                                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

                                      currentIndex = index;

                                      context.goNamed(
                                        navbarConfigs[currentIndex].routeName,
                                      );
                                    },
                                    children: const [
                                      RepaintBoundary(
                                        child: TrailDirectory(),
                                      ),
                                      RepaintBoundary(
                                        child: TrailRulesPage(),
                                      ),
                                      RepaintBoundary(
                                        child: BookingPage(),
                                      ),
                                      RepaintBoundary(
                                        child: ProfilePage(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SafeArea(
                  child: Scaffold(
                    body: TimberlandContainer(
                      child: Center(
                        child: RepaintBoundary(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: RepaintBoundary(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
