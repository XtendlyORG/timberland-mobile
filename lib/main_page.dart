// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/bottom_navbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/core/presentation/widgets/drawer_iconbutton.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_tab.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_user.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
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
  late final List<BottomNavBarConfigs> configs;
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
    configs = [
      BottomNavBarConfigs(
        icon: const Icon(Icons.map_outlined),
        label: 'Trail',
        routeName: Routes.trails.name,
        pageBuider: _buildTrailsPage,
      ),
      BottomNavBarConfigs(
        icon: const Image(
          image: AssetImage('assets/icons/rules-icon.png'),
          height: 24,
          width: 24,
        ),
        label: 'Rules',
        routeName: Routes.rules.name,
        pageBuider: (context) {
          return const Center(
            child: Text("rules"),
          );
        },
      ),
      BottomNavBarConfigs(
        icon: const Image(
          image: AssetImage('assets/icons/emergency-icon.png'),
          height: 24,
          width: 24,
          color: Color(0xffF60505),
        ),
        label: 'Emergency',
        routeName: Routes.emergency.name,
      ),
      BottomNavBarConfigs(
        icon: const Image(
          image: AssetImage('assets/icons/profile-icon.png'),
          height: 24,
          width: 24,
        ),
        label: 'Profile',
        routeName: Routes.profile.name,
        pageBuider: _buildProfilePage,
      ),
    ];
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
              child: InheritedUser(
                user: state.user,
                child: Scaffold(
                  endDrawer: const Dashboard(),
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    actions: const [
                      DrawerIconButton(),
                    ],
                  ),
                  extendBodyBehindAppBar: true,
                  bottomNavigationBar: InheritedTabIndex(
                    tabIndex: currentIndex,
                    child: BottomNavBar(
                      configs: configs,
                      onTap: (index) {
                        pageController.jumpToPage(
                          index < 2 ? index : index - 1,
                        );
                      },
                    ),
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
                                WidgetsBinding
                                    .instance.focusManager.primaryFocus
                                    ?.unfocus();

                                currentIndex = index < 2 ? index : index + 1;

                                context.goNamed(
                                  configs[currentIndex].routeName,
                                );
                              },
                              children: configs
                                  .where((config) => config.pageBuider != null)
                                  .map(
                                    (config) => RepaintBoundary(
                                      child: config.pageBuider!(context),
                                    ),
                                  )
                                  .toList(),
                            ),
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

  Widget _buildProfilePage(BuildContext context) {
    return const Center(
      child: Text("Profile Page"),
    );
  }
}
