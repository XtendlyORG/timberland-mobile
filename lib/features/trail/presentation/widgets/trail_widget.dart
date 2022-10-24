// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/expanded_image.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
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
            height: 180,
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: CachedNetworkImage(
              imageUrl: trail.featureImageUrl,
              imageBuilder: (ctx, imageProvider) {
                final tag = DateTime.now();
                return Hero(
                  tag: tag,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ExpandedImage(
                              imageProvider: imageProvider,
                              tag: tag,
                            );
                          },
                        ),
                      );
                    },
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                );
              },
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              placeholder: (context, url) {
                return Container(
                  color: TimberlandColor.lightBlue,
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  alignment: Alignment.center,
                  color: TimberlandColor.lightBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        size: 48,
                      ),
                      Text(
                        "Failed to load Image",
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
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
                            color: trail.difficulty != Difficulties.easiest
                                ? trail.difficulty.primaryColor
                                : trail.difficulty.secondaryColor,
                          )),
                  TextSpan(
                    text: trail.trailName,
                    style: Theme.of(context).textTheme.titleMedium,
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
