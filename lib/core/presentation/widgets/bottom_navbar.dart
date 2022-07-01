// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_tab.dart';
import 'package:timberland_biketrail/core/router/router.dart';

class BottomNavBar extends StatefulWidget {
  final List<BottomNavBarConfigs> configs;
  final void Function(int index) onTap;

  const BottomNavBar({
    Key? key,
    required this.configs,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = InheritedTabIndex.of(context).tabIndex;

    log('Navbar Rebuilt: $currentIndex');
    return BottomNavigationBar(
      items: widget.configs
          .map(
            (navBarConfig) => BottomNavigationBarItem(
              icon: navBarConfig.icon,
              label: navBarConfig.label,
              tooltip: navBarConfig.label,
            ),
          )
          .toList(),
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (widget.configs[index].routeName != Routes.emergency.name) {
          widget.onTap(index);
        } else {
          // TODO: call emergency usecase here
          log('CALL EMERGENCY HERE');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("EmERGECY"),
            ),
          );
        }
      },
    );
  }
}

class BottomNavBarConfigs {
  final Icon icon;
  final String label;
  final String routeName;
  final Widget Function(BuildContext context)? pageBuider;
  const BottomNavBarConfigs({
    required this.icon,
    required this.label,
    required this.routeName,
    this.pageBuider,
  });
}
