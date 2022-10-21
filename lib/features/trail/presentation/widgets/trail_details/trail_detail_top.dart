// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:video_player/video_player.dart';

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

    final isVideo = trail.mapImageUrl.split('.').last == 'mp4';
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
              decoration: BoxDecoration(
                color: TimberlandColor.lightBlue,
                image: isVideo
                    ? null
                    : DecorationImage(
                        image: NetworkImage(trail.mapImageUrl),
                        fit: BoxFit.fill,
                      ),
              ),
              child: isVideo
                  ? TrailVideo(
                      url: trail.mapImageUrl,
                    )
                  : null,
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

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? VideoPlayer(
            _controller,
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
