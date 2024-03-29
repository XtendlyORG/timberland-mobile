// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';

class TrailRuleWidget extends StatelessWidget {
  final String trailRule;
  const TrailRuleWidget({
    Key? key,
    required this.trailRule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\u2022',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          width: kVerticalPadding,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: trailRule.trim(),
                ),
              ],
            ),
            style: Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
