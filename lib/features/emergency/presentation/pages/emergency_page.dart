// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/core/utils/string_extensions.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';
import 'package:timberland_biketrail/features/emergency/presentation/widgets/animated_circular_splash.dart';
import 'package:vibration/vibration.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/themes/timberland_color.dart';

enum CallStatus {
  initializing,
  ringing,
  connected;
}

enum CallDirection { incoming, outgoing }

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({
    Key? key,
    required this.callDirection,
  }) : super(key: key);
  final CallDirection callDirection;

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool muted = false;
  int? remoteUID;
  CallStatus status = CallStatus.initializing;
  Widget callStatusIcon = const Icon(
    Icons.call_end_rounded,
    size: 64,
    color: TimberlandColor.secondaryColor,
    key: ValueKey(1),
  );
  late final EmergencyBloc bloc;

  late RtcEngine _engine;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );

    initialize().then((value) {
      bloc = BlocProvider.of<EmergencyBloc>(context);

      if (bloc.state is EmergencyTokenFetched) {
        final state = bloc.state as EmergencyTokenFetched;

        log(name: "id", state.configs.emergencyId.toString());

        if (widget.callDirection == CallDirection.outgoing) {
          if (state.configs.emergencyId < 0) {
            bloc.add(
              FetchEmergencyTokenEvent(
                channelID: 'tmbt-emergency-${Session().currentUser!.id}',
              ),
            );
            return;
          }

          bloc.add(
            ReconnectToSocket(
              config: state.configs,
            ),
          );
          return;
        }

        _joinChannel(state.configs);
      } else {
        bloc.add(
          FetchEmergencyTokenEvent(
            channelID: 'tmbt-emergency-${Session().currentUser!.id}',
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    if (status != CallStatus.connected &&
        widget.callDirection == CallDirection.outgoing) {
      log(name: "Emergency", "Leaving channel");
      bloc.add(
        RegisterMissedCallEvent(
          config: (bloc.state as EmergencyTokenFetched).configs,
        ),
      );
      bloc.add(
        DeclineCallEvent(
          memberID: Session().currentUser!.id,
        ),
      );
    }
    _controller.dispose();
    _engine.leaveChannel();
    _engine.release();
    FlutterRingtonePlayer.stop();
    Vibration.cancel();
    super.dispose();
  }

  Future<void> initialize() async {
    final String appID = serviceLocator<EnvironmentConfig>().agoraAppId;
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
    _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileSpeechStandard,
      scenario: AudioScenarioType.audioScenarioMeeting,
    );
    _engine.enableAudioVolumeIndication(
      interval: 250,
      smooth: 3,
      reportVad: true,
    );

    _engine.setDefaultAudioRouteToSpeakerphone(true);
    _engine.disableVideo();
    return;
  }

  void _addAgoraEventHandlers() {
    _engine.registerEventHandler(RtcEngineEventHandler(
      onAudioVolumeIndication:
          (connection, speakers, speakerNumber, totalVolume) {
        if (status == CallStatus.connected) {
          for (AudioVolumeInfo e in speakers) {
            if (e.uid == remoteUID && (e.volume ?? 0) > 100) {
              _controller.forward().then((value) => _controller.reset());
            }
          }
        }
      },
      onError: (code, message) {
        if (code == ErrorCodeType.errTokenExpired) {
          BlocProvider.of<EmergencyBloc>(context).add(
            FetchEmergencyTokenEvent(
              channelID: 'tmbt-emergency-${Session().currentUser!.id}',
            ),
          );
        }
        log("$code - $message");
        Vibration.cancel();
        FlutterRingtonePlayer.stop();
      },
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() {
          status = CallStatus.ringing;
          callStatusIcon = const Icon(
            Icons.ring_volume_rounded,
            size: 64,
            color: TimberlandColor.secondaryColor,
            key: ValueKey(2),
          );
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
          remoteUID = uid;
          status = CallStatus.connected;
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

  void _joinChannel(EmergencyConfigs configs) {
    log(configs.uid.toString());
    log(configs.token);
    _engine.joinChannel(
      token: configs.token,
      channelId: configs.channelID,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
      ),
      uid: configs.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: BlocListener<EmergencyBloc, EmergencyState>(
        listener: (context, state) {
          if (state is EmergencyTokenFetched) {
            _joinChannel(state.configs);
          }
        },
        child: DecoratedSafeArea(
          child: TimberlandScaffold(
            titleText: "Emergency",
            extendBodyBehindAppbar: true,
            disableBackButton: true,
            showNavbar: false,
            index: 4,
            body: Padding(
              padding: const EdgeInsets.all(kHorizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 300,
                    child: status == CallStatus.connected
                        ? AnimatedBuilder(
                            animation: CurvedAnimation(
                              parent: _controller,
                              curve: Curves.linear,
                            ),
                            builder: (context, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  AnimatedCircularSplash(
                                    controller: _controller,
                                    radius: 100,
                                  ),
                                  AnimatedCircularSplash(
                                    controller: _controller,
                                    radius: 120,
                                  ),
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 250),
                                  child: callStatusIcon,
                                  transitionBuilder: (child, animation) {
                                    return ScaleTransition(
                                      scale: animation,
                                      child: child,
                                    );
                                  },
                                ),
                                AutoSizeText(
                                  '${status.name.toTitleCase()}...',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                  ),
                  Text(
                    status == CallStatus.connected
                        ? 'You are now connected to TMBT Admin station'
                        : 'After pressing the emergency button, we will contact our nearest admin station to your current location.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: kVerticalPadding,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: FilledTextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: TimberlandColor.lightRed,
                        foregroundColor: TimberlandColor.background,
                      ),
                      child: const Icon(
                        Icons.call_end_rounded,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
