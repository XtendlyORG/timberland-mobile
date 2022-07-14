import 'package:flutter/material.dart';

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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Length\n',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextSpan(
                  text: '${trail.length} mi',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            textAlign: TextAlign.start,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Elevation Gain\n',
                  style: Theme.of(context).textTheme.caption,
                ),
                TextSpan(
                  text: '${trail.length} ft',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ],
            ),
            textAlign: TextAlign.start,
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
      ),
    );
  }
}
