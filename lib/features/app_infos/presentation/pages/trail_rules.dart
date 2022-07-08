import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/refreshable_scrollview.dart';

class TrailRulesPage extends StatelessWidget {
  const TrailRulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshableScrollView(
      onRefresh: () async {
        log('refresh trail rules');
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: AutoSizeText(
              'Trail Rules',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
