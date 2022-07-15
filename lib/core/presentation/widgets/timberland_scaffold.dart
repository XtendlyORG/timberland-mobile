// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:timberland_biketrail/core/constants/navbar_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/bottom_navbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_appbar.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_container.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';

class TimberlandScaffold extends StatelessWidget {
  final Widget body;
  final String? titleText;
  final bool extendBodyBehindAppbar;
  final ScrollPhysics? physics;
  final List<Widget>? actions;
  const TimberlandScaffold({
    Key? key,
    required this.body,
    this.titleText,
    this.extendBodyBehindAppbar = false,
    this.physics,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: TimberlandAppbar(
            actions: actions,
            backButton: Tooltip(
              message: 'Back',
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
              ),
            ),
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
        body: TimberlandContainer(
          child: SizedBox.expand(
            child: ListView(
              padding: extendBodyBehindAppbar ? EdgeInsets.zero : null,
              // mainAxisAlignment: MainAxisAlignment.center,
              // shrinkWrap: true,
              physics: physics,
              children: [
                if (titleText != null)
                  Center(
                    child: AutoSizeText(
                      titleText!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                body,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
