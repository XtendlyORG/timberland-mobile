import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../domain/entities/trail.dart';

class TrailSpecs extends StatelessWidget {
  const TrailSpecs({
    Key? key,
    required this.trail,
    this.maxWidth = 400,
  }) : super(key: key);

  final Trail trail;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Distance\n',
                style: Theme.of(context).textTheme.caption,
              ),
              TextSpan(
                text: '${trail.distance %1 == 0? trail.distance.toInt():trail.distance} ${trail.unit}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          width: kHorizontalPadding,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Route Type\n',
                style: Theme.of(context).textTheme.caption,
              ),
              TextSpan(
                text: trail.routeType,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}
