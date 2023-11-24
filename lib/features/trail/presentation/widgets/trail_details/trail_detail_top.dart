// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/presentation/widgets/inherited_widgets/inherited_trail.dart';
import '../../../domain/entities/trail.dart';

class TrailDetailTop extends StatefulWidget {
  const TrailDetailTop({Key? key}) : super(key: key);

  @override
  _TrailDetailTopState createState() => _TrailDetailTopState();
}

class _TrailDetailTopState extends State<TrailDetailTop> {
  final PageController _pageController = PageController();
  int currIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Trail trail = InheritedTrail.of(context).trail!;

    final isVideo = trail.mapImageUrl.first.path.split('.').last == 'mp4';
    return Stack(
      children: [
        Hero(
          tag: trail.trailId,
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return ExpandedImage(
              //         imageProvider: CachedNetworkImageProvider(
              //           trail.mapImageUrl,
              //         ),
              //         tag: trail.trailId,
              //       );
              //     },
              //   ),
              // );
            },
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: TimberlandColor.lightBlue,
              ),
              child: Stack(
                children: [
                  isVideo
                      ? PageView.builder(
                          controller: _pageController,
                          itemCount: trail.mapImageUrl.length,
                          onPageChanged: (index) {
                            setState(() {
                              currIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return TrailVideo(
                              url: trail.mapImageUrl[(trail.mapImageUrl.length - 1) - index].path,
                            );
                          },
                        )
                      : PageView.builder(
                          controller: _pageController,
                          itemCount: trail.mapImageUrl.length,
                          onPageChanged: (index) {
                            setState(() {
                              currIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(trail.mapImageUrl[(trail.mapImageUrl.length - 1) - index].path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /* CircleAvatar(
                            backgroundColor: TimberlandColor.primary,
                            radius: 20,
                            child: IconButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOutCubic,
                                );
                              },
                              icon: const Icon(
                                Icons.chevron_left,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ), */
                          Visibility(
                            visible: currIndex != trail.mapImageUrl.length - 1,
                            child: CircleAvatar(
                              backgroundColor: TimberlandColor.primary,
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOutCubic,
                                  );
                                },
                                icon: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        /*  Container(
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
        ), */
      ],
    );
  }
}

class TrailVideo extends StatefulWidget {
  final String url;
  const TrailVideo({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<TrailVideo> createState() => _TrailVideoState();
}

class _TrailVideoState extends State<TrailVideo> {
  late VideoPlayerController _controller;
  double _opacity = 1;
  late Timer _timer;
  AnimationController? iconCtrl;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _opacity = 0;
      });
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? GestureDetector(
            onTap: () {
              setState(() {
                _opacity = 1;
              });
              if (_controller.value.isPlaying) {
                log(iconCtrl.toString());
                _timer.cancel();
                iconCtrl?.reverse();
                _controller.pause();
              } else {
                iconCtrl?.forward();
                _controller.play();

                _timer = Timer.periodic(const Duration(seconds: 2), (_) {
                  setState(() {
                    _opacity = 0;
                  });
                  _timer.cancel();
                });
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(
                  _controller,
                ),
                Opacity(
                  opacity: _opacity,
                  child: AnimatedPausePlayIcon(
                    onCreate: (ctrl) {
                      iconCtrl ??= ctrl;
                    },
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }
}

class AnimatedPausePlayIcon extends StatefulWidget {
  const AnimatedPausePlayIcon({
    Key? key,
    required this.onCreate,
  }) : super(key: key);
  final void Function(AnimationController ctrl) onCreate;

  @override
  State<AnimatedPausePlayIcon> createState() => _AnimatedPausePlayIconState();
}

class _AnimatedPausePlayIconState extends State<AnimatedPausePlayIcon> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    widget.onCreate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(.7),
        shape: BoxShape.circle,
      ),
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        size: 48,
        color: Theme.of(context).primaryColor,
        progress: controller,
      ),
    );
  }
}
