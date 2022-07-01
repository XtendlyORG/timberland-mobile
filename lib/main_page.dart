// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/bottom_navbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_tab.dart';
import 'package:timberland_biketrail/core/router/router.dart';

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
        icon: const Icon(Icons.map),
        label: 'Trail',
        routeName: Routes.trails.name,
        pageBuider: _buildTrailsPage,
      ),
      BottomNavBarConfigs(
        icon: const Icon(Icons.person),
        label: 'Profile',
        routeName: Routes.profile.name,
        pageBuider: _buildProfilePage,
      ),
      BottomNavBarConfigs(
        icon: const Icon(
          Icons.warning_rounded,
          color: Colors.red,
        ),
        label: 'Emergency',
        routeName: Routes.emergency.name,
      ),
      BottomNavBarConfigs(
          icon: const Icon(Icons.rule),
          label: 'Rules',
          routeName: Routes.rules.name,
          pageBuider: (context) {
            return const Center(
              child: Text("rules"),
            );
          }),
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

    return Scaffold(
      endDrawer: const Dashboard(),
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
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          // dismis keyboard
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

          currentIndex = index < 2 ? index : index + 1;

          context.goNamed(
            configs[currentIndex].routeName,
          );
        },
        children: configs
            .where((config) => config.pageBuider != null)
            .map((config) => config.pageBuider!(context))
            .toList(),
      ),
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
