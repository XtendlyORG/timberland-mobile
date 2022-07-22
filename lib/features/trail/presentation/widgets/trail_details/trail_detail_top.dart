import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../domain/entities/trail.dart';

class TrailDetailTop extends StatelessWidget {
  const TrailDetailTop({
    Key? key,
    required this.trail,
  }) : super(key: key);

  final Trail trail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        image: DecorationImage(
          image: NetworkImage(trail.mapImageUrl),
          fit: BoxFit.fill,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(.5), BlendMode.darken),
        ),
      ),
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kHorizontalPadding * 1.5,
      ),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Text(
            trail.trailName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).backgroundColor,
                ),
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
                decoration: BoxDecoration(
                    color: trail.difficulty.backgroundColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  trail.difficulty.name,
                  style: TextStyle(
                    color: trail.difficulty.textColor,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Text(
            trail.location,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).backgroundColor,
                ),
          ),
        ],
      ),
    );
  }
}
