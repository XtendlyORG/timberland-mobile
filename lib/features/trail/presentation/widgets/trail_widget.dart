// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';

class TrailWidget extends StatelessWidget {
  final Trail trail;
  const TrailWidget({
    Key? key,
    required this.trail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // image: const DecorationImage(
            //   image: NetworkImage(''),
            // ),
          ),
          child: const Placeholder(),
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: '${trail.difficulty}\n',
          ),
          TextSpan(
            text: trail.trailName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ])),
      ],
    );
  }
}
