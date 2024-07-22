import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_widget.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';

class AnnouncementViewPage extends StatelessWidget {
  const AnnouncementViewPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);
  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
      return DecoratedSafeArea(
        child: TimberlandScaffold(
          backButtonColor: Colors.white,
          extendBodyBehindAppbar: true,
          body: SizedBox.fromSize(
            size: MediaQuery.of(context).size,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                            Colors.white,
                            Colors.transparent,
                                ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            stops: [0, 0.5],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
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
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            title,
                            minFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          AutoSizeText(
                            removeHtmlTags(description),
                            minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
