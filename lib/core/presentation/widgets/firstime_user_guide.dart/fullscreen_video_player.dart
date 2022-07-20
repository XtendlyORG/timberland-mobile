// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'custom_video_player.dart';

class FullScreenVideo extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  const FullScreenVideo({
    Key? key,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: SizedBox(
                height: videoPlayerController.value.size.height,
                width: videoPlayerController.value.size.width,
                child: CustomVideoPlayer(
                  videoPlayerController: videoPlayerController,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: VideoPlayerActions(
                  videoPlayerController: videoPlayerController,
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.fullscreen_exit,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerActions extends StatelessWidget {
  final Widget? trailing;
  const VideoPlayerActions({
    Key? key,
    this.trailing,
    required this.videoPlayerController,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VideoProgressIndicator(
            videoPlayerController,
            allowScrubbing: true,
            colors: VideoProgressColors(
              playedColor: Theme.of(context).primaryColor,
            ),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }
}
