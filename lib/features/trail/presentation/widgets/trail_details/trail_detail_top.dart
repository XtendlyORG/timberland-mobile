import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/presentation/widgets/inherited_widgets/inherited_trail.dart';
import '../../../domain/entities/trail.dart';

class TrailDetailTop extends StatelessWidget {
  const TrailDetailTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Trail trail = InheritedTrail.of(context).trail!;
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
                    color: trail.difficulty.primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  trail.difficulty.name,
                  style: TextStyle(
                    color: trail.difficulty.secondaryColor,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          
        ],
      ),
    );
  }
}
