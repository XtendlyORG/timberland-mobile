// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:timberland_biketrail/core/presentation/widgets/bottom_navbar.dart';

class MainPage extends StatelessWidget {
  final Widget widget;
  const MainPage({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final List<BottomNavBarConfigs> configs = const [
    BottomNavBarConfigs(
      icon: Icon(Icons.home),
      label: '',
      routeName: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        configs: configs,
      ),
      body: widget,
    );
  }
}
