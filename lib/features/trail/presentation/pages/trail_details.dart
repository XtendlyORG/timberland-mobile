// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_widget.dart';

class TrailDetails extends StatelessWidget {
  const TrailDetails({
    Key? key,
    required this.trail,
  }) : super(key: key);

  final Trail trail;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return TimberlandScaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: NetworkImage(trail.mapImageUrl),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.2), BlendMode.darken),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
                vertical: mediaQuery.padding.top + kVerticalPadding,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      trail.trailName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).backgroundColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Container(
                  height: mediaQuery.orientation == Orientation.portrait
                      ? mediaQuery.size.longestSide - 300 - kToolbarHeight
                      : mediaQuery.size.longestSide -
                          300 +
                          mediaQuery.padding.top,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor.withOpacity(.5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: mediaQuery.padding.top + kVerticalPadding,
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
            ),
          ),
        ],
      ),
    );
  }
}
