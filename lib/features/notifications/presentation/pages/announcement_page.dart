// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/pages/announcement_slider.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';

class AnnouncementsPage extends StatefulWidget {
  AnnouncementsPage({Key? key, required this.announcements}) : super(key: key);

  List<Announcement> announcements;

  @override
  _AnnouncementsPageState createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {
  void timer() async {
    await Future.delayed(const Duration(seconds: 2));
    context.goNamed(Routes.home.name);
  }

  @override
  void initState() {
    timer();
    super.initState();
  }

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
            fit: BoxFit.cover,
          ),
        ),
        //AnnouncementSlider(announcements: announcements),
      ],
    );
  }
}

class AnnouncementSlider extends StatefulWidget {
  const AnnouncementSlider({
    Key? key,
    required this.announcements,
    required this.timer
  }) : super(key: key);
  final List<AnnouncementModel> announcements;
  final VoidCallback timer;

  @override
  State<AnnouncementSlider> createState() => _AnnouncementSliderState();
}

class _AnnouncementSliderState extends State<AnnouncementSlider> {
  late final PageController controller;
  late int currentIndex;

  Timer? _timer;
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 3500), (timer) {
      if(widget.announcements.length == (currentIndex + 1)){
        // context.pushNamed(Routes.home.name);
        widget.timer();
      }else{
        controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
        setState(() {
          currentIndex += 1;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    controller = PageController();
    currentIndex = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25.0,
            // horizontal: 25.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  context.pushNamed(Routes.home.name);
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
                children: [
                  PageView.builder(
                    controller: controller,
                    onPageChanged: (index) {
                      if(index < currentIndex){
                        _timer?.cancel();
                      }
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: widget.announcements.length,
                    itemBuilder: (context, index) {
                      return AnnouncementSlide(
                        title: widget.announcements[index].title ?? "Announcement!",
                        description: (widget.announcements[index].content ?? "Welcome to Timberland Mountain Bike Park Mobile").split("\n").isNotEmpty
                      ? removeHtmlTags((widget.announcements[index].content ?? "Welcome to Timberland Mountain Bike Park Mobile").split("\n").first)
                      : removeHtmlTags((widget.announcements[index].content ?? "Welcome to Timberland Mountain Bike Park Mobile")),
                        imagePath: widget.announcements[index].image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHwJRHWhpFcogNg6AGOI2Km1AZSeWLKKdE4g&s",
                        cancelTimer: () {
                          // Cancel Auto Slide
                          _timer?.cancel();
                        },
                      );
                    },
                  ),
                ],
              ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: widget.announcements.length,
          effect: const ExpandingDotsEffect(
            offset: 8.0,
            dotWidth: 8.0,
            dotHeight: 8.0,
            spacing: 4.0,
            radius: 8.0,
            activeDotColor: TimberlandColor.primary,
          ),
          onDotClicked: (index) {
            _timer?.cancel();
            currentIndex = index;
            controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
        MediaQuery.of(context).size.height > 700
        ?  const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
              // horizontal: 25.0
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 6.0,
              // horizontal: 25.0
            ),
          ),
        // Expanded(child: Container(color: Colors.green)),
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: TimberlandColor.background),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: kVerticalPadding * .5,
                  ),
                  Text(
                    announcement.title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: TimberlandColor.background),
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
