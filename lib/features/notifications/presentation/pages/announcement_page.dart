// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_scroll_behavior.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({
    Key? key,
    required this.announcements,
  }) : super(key: key);
  final List<Announcement> announcements;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.fromSize(
          size: MediaQuery.of(context).size,
          child: Image.asset(
            'assets/splash/splash_background.png',
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(.3),
            fit: BoxFit.fill,
          ),
        ),
        AnnouncementSlider(announcements: announcements),
      ],
    );
  }
}

class AnnouncementSlider extends StatefulWidget {
  const AnnouncementSlider({
    Key? key,
    required this.announcements,
  }) : super(key: key);
  final List<Announcement> announcements;

  @override
  State<AnnouncementSlider> createState() => _AnnouncementSliderState();
}

class _AnnouncementSliderState extends State<AnnouncementSlider> {
  late final PageController controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400,
            maxWidth: 300,
          ),
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                scrollBehavior: const CustomScrollBehavior(),
                itemCount: widget.announcements.length,
                padEnds: false,
                onPageChanged: (value) {},
                itemBuilder: (context, index) {
                  final announcement = widget.announcements[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kVerticalPadding),
                    child: AnnouncementWidget(announcement: announcement),
                  );
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: kVerticalPadding * 1.5,
                    top: kVerticalPadding * .5,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.canPop(context)
                          ? context.pop()
                          : context.goNamed(Routes.home.name);
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TimberlandColor.primary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: TimberlandColor.background,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: kVerticalPadding,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: widget.announcements.length,
          effect: const ExpandingDotsEffect(
            activeDotColor: TimberlandColor.primary,
          ),
          onDotClicked: (index) {
            currentIndex = index;
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
      ],
    );
  }
}

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (announcement.imagePath != null)
              CachedNetworkImage(imageUrl: announcement.imagePath!)
            else
              Image.asset(
                'assets/icons/announcement-icon.png',
                height: 128,
                width: 120,
              ),
            const SizedBox(
              height: kVerticalPadding * 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kVerticalPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    announcement.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: TimberlandColor.background),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kVerticalPadding * .5,
                  ),
                  Text(
                    announcement.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: TimberlandColor.background),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kVerticalPadding,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
