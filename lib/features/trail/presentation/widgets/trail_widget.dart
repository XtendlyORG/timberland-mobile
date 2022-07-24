// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_specs.dart';

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
                  fit: BoxFit.fitWidth),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: '${trail.difficulty.name}\n',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: trail.difficulty.primaryColor,
                          )),
                  TextSpan(
                    text: '${trail.trailName}\n',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: trail.location,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
          ),
          TrailSpecs(trail: trail)
        ],
      ),
    );
  }
}
