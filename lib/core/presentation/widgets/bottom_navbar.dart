// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';

class BottomNavBar extends StatefulWidget {
  final List<BottomNavBarConfigs> configs;
  const BottomNavBar({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
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
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        context.goNamed(
          Routes.home.path,
          params: {'tab': widget.configs[index].routeName},
        );
      },
    );
  }
}

class BottomNavBarConfigs extends Equatable {
  final Icon icon;
  final String label;
  final String routeName;
  const BottomNavBarConfigs({
    required this.icon,
    required this.label,
    required this.routeName,
  });

  @override
  List<Object> get props => [icon, label, routeName];
}
