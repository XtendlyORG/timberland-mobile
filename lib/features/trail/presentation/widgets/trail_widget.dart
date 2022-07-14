// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';

class TrailWidget extends StatelessWidget {
  final Trail trail;
  const TrailWidget({
    Key? key,
    required this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          Routes.specificTrail.name,
          params: {
            'id': trail.trailId,
          },
          extra: trail,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(trail.featureImageUrl),
              ),
            ),
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: '${trail.difficulty.name}\n',
                style: TextStyle(
                  color: trail.difficulty.difficultyColor,
                )),
            TextSpan(
              text: '${trail.trailName}\n',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextSpan(
              text: trail.location,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ])),
          TrailSpecs(trail: trail)
        ],
      ),
    );
  }
}

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
