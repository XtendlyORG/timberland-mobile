// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:timberland_biketrail/core/constants/navbar_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/profile_page.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/profile_settings.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/pages/trail_rules.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/booking_page.dart';
import 'package:timberland_biketrail/features/trail/presentation/pages/trail_directory.dart';

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

  @override
  void initState() {
    super.initState();
    currentIndex = widget.selectedTabIndex;
    pageController = PageController(
      initialPage: currentIndex,
      keepPage: true,
    );
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
                endDrawer: const Dashboard(),
                appBar: TimberlandAppbar(
                  actions: currentIndex == 3
                      ? [
                          ProfileSettingsButton(
                            user: state.user,
                          ),
                        ]
                      : null,
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
                              WidgetsBinding.instance.focusManager.primaryFocus
                                  ?.unfocus();

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
}
