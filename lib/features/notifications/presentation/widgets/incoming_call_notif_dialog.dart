import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';
import 'package:timberland_biketrail/features/emergency/presentation/pages/emergency_page.dart';
import 'package:vibration/vibration.dart';

class IncomingCallNotifDialog extends StatelessWidget {
  const IncomingCallNotifDialog({
    Key? key,
    required this.incomingCallNotifCtrl,
  }) : super(key: key);

  final AnimationController incomingCallNotifCtrl;

  @override
  Widget build(BuildContext context) {
    final emergencyBloc = BlocProvider.of<EmergencyBloc>(context);
    // emergencyBloc.add(
    //   AnswerIncomingCallEvent(
    //       configs: (BlocProvider.of<NotificationsBloc>(context).state
    //               as NotificationRecieved)
    //           .configs!),
    // );
    return Container(
      padding: const EdgeInsets.only(
        top: kToolbarHeight / 2,
        bottom: kToolbarHeight / 4,
        left: kVerticalPadding,
        right: kVerticalPadding,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: kVerticalPadding,
      ),
      decoration: BoxDecoration(
        color: TimberlandColor.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(1, 1))
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'TMBT Admin is calling you...',
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: kVerticalPadding,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: FilledTextButton(
                    onPressed: () {
                      incomingCallNotifCtrl.reverse();
                      Vibration.cancel();
                      FlutterRingtonePlayer.stop();
                      
                      emergencyBloc.add(
                        DeclineCallEvent(
                          memberID: Session().currentUser!.id,
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: TimberlandColor.lightRed,
                      foregroundColor: TimberlandColor.background,
                    ),
                    child: const Icon(Icons.call_end),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    thickness: 1.5,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                Expanded(
                  child: FilledTextButton(
                    onPressed: () {
                      incomingCallNotifCtrl.reverse();
                      context.pushNamed(
                        Routes.emergency.name,
                        extra: CallDirection.incoming,
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: TimberlandColor.accentColor,
                      foregroundColor: TimberlandColor.background,
                    ),
                    child: const Icon(Icons.call),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
