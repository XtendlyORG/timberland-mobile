// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/navbar_configs.dart';
import 'package:timberland_biketrail/core/presentation/pages/first_time_user_page.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/profile_page.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/pages/trail_rules.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
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
  Widget build(BuildContext context) {
    if (currentIndex != widget.selectedTabIndex) {
      currentIndex = widget.selectedTabIndex;
      pageController.jumpToPage(
        currentIndex,
      );
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (previous, current) {
          if (current is UserGuideFinished) {
            context.goNamed(Routes.booking.name);
          }
          return current is! UserGuideFinished;
        },
        builder: (context, state) {
          log("State is: $state");
          if (state is UnAuthenticated) {
            BlocProvider.of<AuthBloc>(context).add(
              FetchUserEvent(uid: Session().currentUID!),
            );
          } else if (state is Authenticated) {
            if (state.firstTimeUser) {
              return const FirstTimeUserPage();
            }
            return SafeArea(
              child: Scaffold(
                endDrawer: const Dashboard(),
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: TimberlandAppbar(
                    actions: currentIndex == 3
                        ? [
                            CircularIconButton(
                              onTap: () {
                                context.pushNamed(
                                  Routes.updateProfile.name,
                                  extra: state.user,
                                );
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Theme.of(context).backgroundColor,
                                size: 18,
                              ),
                              size: 24,
                            ),
                          ]
                        : null,
                  ),
                ),
                extendBodyBehindAppBar: true,
                bottomNavigationBar: BottomNavBar(
                  index: currentIndex,
                  configs: navbarConfigs,
                  onTap: (index) {
                    pageController.jumpToPage(
                      index < 2 ? index : index - 1,
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

                              currentIndex = index < 2 ? index : index + 1;

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
      ),
    );
  }
}
