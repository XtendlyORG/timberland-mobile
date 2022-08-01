// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/emergency_dialog.dart';
import 'package:timberland_biketrail/core/router/router.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  final List<BottomNavBarConfigs> configs;
  final void Function(int index) onTap;

  const BottomNavBar({
    Key? key,
    required this.index,
    required this.configs,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
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
      currentIndex: widget.index,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).primaryColor,
      selectedItemColor: Theme.of(context).backgroundColor,
      unselectedItemColor: Theme.of(context).primaryColorLight,
      selectedIconTheme: IconThemeData(
        color: Theme.of(context).backgroundColor,
      ),
      unselectedIconTheme: IconThemeData(
        color: Theme.of(context).backgroundColor,
      ),
      onTap: (index) {
        if (widget.configs[index].routeName != Routes.emergency.name) {
          widget.onTap(index);
        } else {
          showDialog(
            context: context,
            builder: (ctx) {
              return const EmergencyDialog();
            },
          );
        }
      },
    );
  }
}

class BottomNavBarConfigs {
  final Widget icon;
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
