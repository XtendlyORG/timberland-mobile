// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/dashboard/presentation/widgets/dashboard.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';
import '../../../../core/themes/timberland_color.dart';

class EmergencyPage extends StatefulWidget {
  final EmergencyConfigs configs;
  const EmergencyPage({
    Key? key,
    required this.configs,
  }) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool muted = false;
  int? _remoteUid;
  bool _localUserJoined = false;

  late RtcEngine _engine;
  @override
  void initState() {
    super.initState();
    initialize();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    await [Permission.microphone].request();
    if (widget.configs.appID.isEmpty) {
      return;
    }
    _engine = createAgoraRtcEngine();

    await _engine.initialize(RtcEngineContext(
      appId: widget.configs.appID,
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

    await _engine.joinChannel(
      token: widget.configs.token,
      channelId: widget.configs.channelID,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
      ),
      uid: widget.configs.uid,
    );
  }

  void _addAgoraEventHandlers() {
    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (code, message) {
        log("$code - $message");
      },
      onJoinChannelSuccess: (connection, elapsed) {
        setState(() {
          _localUserJoined = true;
        });
      },
      onLeaveChannel: (connection, stats) {
        setState(() {
          _remoteUid = null;
        });
      },
      onUserJoined: (connection, uid, elapsed) {
        setState(() {
          _remoteUid = uid;
        });
      },
      onUserOffline: (connection, uid, reason) {
        setState(() {
          _remoteUid = null;
        });
      },
      onTokenPrivilegeWillExpire: (connection, token) {
        // TODO: Generate new token
        // _engine.renewToken(newToken);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
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
                child: AnimatedBuilder(
                  animation: CurvedAnimation(
                      parent: _controller,
                      curve: Curves.fastLinearToSlowEaseIn),
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // _buildContainer(50 * (1 + _controller.value)),
                        _buildContainer(100 * (1 + _controller.value)),
                        _buildContainer(120 * (1 + _controller.value)),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: TimberlandColor.secondaryColor),
                          padding: const EdgeInsets.all(kHorizontalPadding),
                          child: const Image(
                            image:
                                AssetImage('assets/icons/emergency-icon.png'),
                            height: 64,
                            width: 64,
                          ),
                        ),
                      ],
                    );
                  },
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
            ],
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
