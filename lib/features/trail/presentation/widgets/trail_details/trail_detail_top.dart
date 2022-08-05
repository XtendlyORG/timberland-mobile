import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/presentation/widgets/expanded_image.dart';
import '../../../../../core/presentation/widgets/inherited_widgets/inherited_trail.dart';
import '../../../domain/entities/trail.dart';

class TrailDetailTop extends StatelessWidget {
  const TrailDetailTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Trail trail = InheritedTrail.of(context).trail!;
    return Stack(
      children: [
        Hero(
          tag: trail.trailId,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ExpandedImage(
                      imageProvider: CachedNetworkImageProvider(
                        trail.mapImageUrl,
                      ),
                      tag: trail.trailId,
                    );
                  },
                ),
              );
            },
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
            ),
          ),
        ),
        Container(
          height: 300,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kHorizontalPadding * 1.5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
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
            ],
          ),
        ),
      ],
    );
  }
}
