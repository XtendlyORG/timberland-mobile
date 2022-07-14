import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/trail.dart';
import '../trail_specs.dart';

class TrailDetailBottom extends StatelessWidget {
  const TrailDetailBottom({
    Key? key,
    required this.trail,
  }) : super(key: key);

  final Trail trail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(.5),
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
              children: [
                Text(trail.description),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: kVerticalPadding,
                ),
                TrailSpecs(trail: trail),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
