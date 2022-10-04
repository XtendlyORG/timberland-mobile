// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/timberland_color.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool muted = false;
  bool remoteUserJoined = false;
  String status = 'Connecting...';

  late RtcEngine _engine;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    initialize().then((value) =>
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
          BlocProvider.of<EmergencyBloc>(context).add(
            FetchEmergencyTokenEvent(
              channelID: 'tmbt-emergency-${Session().currentUser!.id}',
            ),
          );
        }));
  }

  @override
  void dispose() {
    _controller.dispose();
    _engine.leaveChannel();
    _engine.release();
    FlutterRingtonePlayer.stop();
    Vibration.cancel();
    super.dispose();
  }

  Future<void> initialize() async {
    final String appID = serviceLocator<EnvironmentConfig>().agoraAppId;
    log(appID);
    await [Permission.microphone].request();
    if (appID.isEmpty) {
      return;
    }
    _engine = createAgoraRtcEngine();

    await _engine.initialize(RtcEngineContext(
      appId: appID,
      channelProfile: ChannelProfileType.channelProfileCommunication1v1,
      audioScenario: AudioScenarioType.audioScenarioMeeting,
    ));

    _addAgoraEventHandlers();
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileSpeechStandard,
      scenario: AudioScenarioType.audioScenarioMeeting,
    );
    await _engine.setDefaultAudioRouteToSpeakerphone(true);
    await _engine.disableVideo();
  }

  void _addAgoraEventHandlers() {
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (code, message) {
        log("$code - $message");
        Vibration.cancel();
        FlutterRingtonePlayer.stop();
      },
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() {
          status = 'Calling...';
        });
        FlutterRingtonePlayer.play(
          android: AndroidSounds.ringtone,
          ios: IosSounds.alarm,
          looping: true,
          volume: 1,
          // asAlarm: true,
        );
        Vibration.vibrate(
          pattern: [500, 1000, 500, 1000],
          intensities: [1, 255],
          duration: 1000,
          repeat: 1,
          // repeat: 20
        );
      },
      onLeaveChannel: (connection, stats) {
        Vibration.cancel();
        FlutterRingtonePlayer.stop();
      },
      onUserJoined: (connection, uid, elapsed) {
        setState(() {
          remoteUserJoined = true;
        });
        Vibration.cancel();
        FlutterRingtonePlayer.stop();
      },
      onUserOffline: (connection, uid, reason) {
        // Remote user left;
        Navigator.pop(context);
      },
      onTokenPrivilegeWillExpire: (connection, token) {
        // TODO: Generate new token
        // _engine.renewToken(newToken);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: BlocListener<EmergencyBloc, EmergencyState>(
        listener: (context, state) async {
          if (state is EmergencyTokenFetched) {
            await _engine.joinChannel(
              token: state.configs.token,
              channelId: state.configs.channelID,
              options: const ChannelMediaOptions(
                clientRoleType: ClientRoleType.clientRoleBroadcaster,
                autoSubscribeAudio: true,
              ),
              uid: state.configs.uid,
            );
          }
        },
        child: DecoratedSafeArea(
          child: TimberlandScaffold(
            titleText: "Emergency",
            extendBodyBehindAppbar: true,
            disableBackButton: true,
            endDrawer: const Dashboard(
              disableEmergency: true,
            ),
            index: 4,
            body: Padding(
              padding: const EdgeInsets.all(kHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: remoteUserJoined
                        ? AnimatedBuilder(
                            animation: CurvedAnimation(
                                parent: _controller,
                                curve: Curves.fastLinearToSlowEaseIn),
                            builder: (context, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  _buildContainer(
                                      100 * (1 + _controller.value)),
                                  _buildContainer(
                                      120 * (1 + _controller.value)),
                                  Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: TimberlandColor.secondaryColor),
                                    padding: const EdgeInsets.all(
                                        kHorizontalPadding),
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/icons/emergency-icon.png'),
                                      height: 64,
                                      width: 64,
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : Center(
                            child: AutoSizeText(
                              status,
                              style: Theme.of(context).textTheme.displaySmall,
                              maxLines: 1,
                            ),
                          ),
                  ),
                  Text(
                    'After pressing the emergency button, we will contact our nearest admin station to your current location.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: kHorizontalPadding,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledTextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: kVerticalPadding,
                        ),
                        child: Icon(
                          Icons.call_end,
                          color: TimberlandColor.background,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            TimberlandColor.secondaryColor.withOpacity(1 - _controller.value),
      ),
    );
  }
}
