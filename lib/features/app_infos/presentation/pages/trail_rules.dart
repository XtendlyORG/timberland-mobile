import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/trail_rules.dart';

import '../widgets/trail_rule_widget.dart';

class TrailRulesPage extends StatelessWidget {
  const TrailRulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight, bottom: 10),
              child: AutoSizeText(
                "Mountain Biker's Responsibility Code",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor.withOpacity(.05), Colors.white.withOpacity(.04), Colors.white.withOpacity(.8)],
                    stops: const [.6, .8, 1],
                  ),
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: LiveList.options(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        options: const LiveOptions(
                          showItemInterval: Duration(milliseconds: 100),
                          visibleFraction: 0.05,
                        ),
                        shrinkWrap: true,
                        itemCount: trailRules.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index, animation) {
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: TrailRuleWidget(
                                trailRule: trailRules[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
