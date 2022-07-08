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
  const TimberlandScaffold({
    Key? key,
    required this.body,
    this.titleText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: TimberlandContainer(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight > constraints.maxWidth
                        ? constraints.maxHeight
                        : constraints.maxWidth,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (titleText != null)
                        Padding(
                          padding: const EdgeInsets.only(top: kToolbarHeight),
                          child: AutoSizeText(
                            titleText!,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      Expanded(child: body),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
