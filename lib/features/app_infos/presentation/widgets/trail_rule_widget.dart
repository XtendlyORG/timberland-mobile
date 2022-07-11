// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

class TrailRuleWidget extends StatelessWidget {
  final TrailRule trailRule;
  const TrailRuleWidget({
    Key? key,
    required this.trailRule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
              text: '${trailRule.rule.trimRight()}. ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: trailRule.note,
          ),
        ],
      ),
    );
  }
}
