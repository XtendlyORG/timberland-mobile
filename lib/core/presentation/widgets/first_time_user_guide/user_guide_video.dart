import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../features/authentication/presentation/bloc/auth_bloc.dart';
import 'custom_video_player.dart';
import 'first_booking_dialog.dart';
import 'fullscreen_video_player.dart';

class UserGuideVideo extends StatefulWidget {
  const UserGuideVideo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserGuideVideo> createState() => _UserGuideVideoState();
}

class _UserGuideVideoState extends State<UserGuideVideo> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      'https://player.vimeo.com/external/517369411.sd.mp4?s=871d54da6489f8d9caa57295ebb733d1e4119e6b&profile_id=164&oauth2_token_id=57447761',
    )..initialize().then((_) {
        setState(() {
          _videoPlayerController.play();
        });
      });
    _videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxHeight: 200,
        maxWidth: 400,
      ),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [BoxShadow(blurRadius: 10)],
      ),
      child: _videoPlayerController.value.isInitialized
          ? Stack(
              children: [
                CustomVideoPlayer(
                  videoPlayerController: _videoPlayerController,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: VideoPlayerActions(
                      videoPlayerController: _videoPlayerController,
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FullScreenVideo(
                                videoPlayerController: _videoPlayerController,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.fullscreen,
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
                      _videoPlayerController.pause();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (ctx) {
                          return FirstBookingDialog(
                            onClose: _videoPlayerController.play,
                            onSubmit: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                const FinishUserGuideEvent(),
                              );
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            )
          : const RepaintBoundary(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
