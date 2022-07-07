// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:timberland_biketrail/core/constants/navbar_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/bottom_navbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_appbar.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';

class TimberlandScaffold extends StatelessWidget {
  final Widget child;
  const TimberlandScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TimberlandAppbar(
          backButton: BackButton(),
        ),
      ),
      endDrawer: const Dashboard(),
      bottomNavigationBar: BottomNavBar(
        index: 0,
        configs: navbarConfigs,
        onTap: (index) {
          context.goNamed(navbarConfigs[index].routeName);
        },
      ),
      body: child,
    );
  }
}
