// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/navbar_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/profile_page.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

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

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnAuthenticated) {
          BlocProvider.of<AuthBloc>(context).add(
            FetchUserEvent(uid: Session().currentUID!),
          );
        } else if (state is Authenticated) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                // TODO: Refresh
                log('refreshed');
              },
              child: Scaffold(
                endDrawer: const Dashboard(),
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: TimberlandAppbar(
                    actions: currentIndex == 3
                        ? [
                            CircularIconButton(
                              onTap: () {},
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
                body: RepaintBoundary(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
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
                            children: [
                              RepaintBoundary(
                                child: _buildTrailsPage(context),
                              ),
                              const RepaintBoundary(
                                child: Center(
                                  child: Text('Rules'),
                                ),
                              ),
                              const RepaintBoundary(
                                child: ProfilePage(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(
          child: RepaintBoundary(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildTrailsPage(BuildContext context) {
    return const Center(
      child: Text("Trail Directory"),
    );
  }
}
