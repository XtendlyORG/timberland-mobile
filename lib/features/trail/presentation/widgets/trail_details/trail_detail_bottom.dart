import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/presentation/widgets/inherited_widgets/inherited_trail.dart';
import '../../../domain/entities/trail.dart';
import '../trail_specs.dart';

class TrailDetailBottom extends StatelessWidget {
  const TrailDetailBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Trail trail = InheritedTrail.of(context).trail!;
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 428,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(.5),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kHorizontalPadding * 1.5,
              horizontal: kHorizontalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trail.description),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                if (trail.expectedDescription != null) ...[
                  Text("WHAT TO EXPECT: ${trail.expectedDescription!}"),
                  const SizedBox(
                    height: kVerticalPadding,
                  ),
                ],
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                TrailSpecs(trail: trail),
                const SizedBox(
                  height: kVerticalPadding,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
