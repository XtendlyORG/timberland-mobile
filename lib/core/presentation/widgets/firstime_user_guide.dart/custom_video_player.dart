import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const CustomVideoPlayer({
    Key? key,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late bool _visible;
  late Timer _timer;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..forward();
    _visible = true;
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _visible = false;
      });
      _timer.cancel();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _visible = true;
        });

        if (widget.videoPlayerController.value.isPlaying) {
          _timer.cancel();
          _animationController.reverse();
          widget.videoPlayerController.pause();
        } else {
          _animationController.forward();
          widget.videoPlayerController.play();

          _timer = Timer.periodic(const Duration(seconds: 2), (_) {
            setState(() {
              _visible = false;
            });
            _timer.cancel();
          });
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          VideoPlayer(
            widget.videoPlayerController,
          ),
          Align(
            alignment: Alignment.center,
            child: Visibility(
              visible: _visible,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor.withOpacity(.7),
                  shape: BoxShape.circle,
                ),
                child: AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  size: 48,
                  color: Theme.of(context).primaryColor,
                  progress: _animationController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
