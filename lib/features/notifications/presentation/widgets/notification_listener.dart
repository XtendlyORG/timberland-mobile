import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';
import 'package:timberland_biketrail/features/emergency/presentation/pages/emergency_page.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/announcement_dialog.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/notification_banner.dart';
import 'package:vibration/vibration.dart';

import 'incoming_call_notif_dialog.dart';

class TMBTNotificationListener extends StatefulWidget {
  const TMBTNotificationListener({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  State<TMBTNotificationListener> createState() =>
      _TMBTNotificationListenerState();
}

class _TMBTNotificationListenerState extends State<TMBTNotificationListener>
    with TickerProviderStateMixin {
  late final AnimationController notificationCtrl;
  late final CurvedAnimation notifAnimation;

  late final AnimationController incomingCallNotifCtrl;
  late final CurvedAnimation incomingCallAnimation;

  late final AnimationController announcementCtrl;
  late final CurvedAnimation announcementAnimation;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmergencyBloc>(context).add(ConnectToSocket());

    // push notification controller
    notificationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    notifAnimation = CurvedAnimation(
      parent: notificationCtrl,
      curve: Curves.easeInBack,
    );

    // emergency dialog controller
    incomingCallNotifCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    incomingCallAnimation = CurvedAnimation(
      parent: incomingCallNotifCtrl,
      curve: Curves.linearToEaseOut,
    );

    // Announcement controller
    announcementCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    announcementAnimation = CurvedAnimation(
      parent: announcementCtrl,
      curve: Curves.linearToEaseOut,
    );
  }

  @override
  void dispose() {
    notifAnimation.dispose();
    notificationCtrl.dispose();

    incomingCallAnimation.dispose();
    incomingCallNotifCtrl.dispose();

    announcementAnimation.dispose();
    announcementCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (ctx, state) {
            if (state is AnnouncementRecieved) {
              // announcementCtrl.forward();
              appRouter.pushNamed(
                Routes.announcements.name,
                extra: state.announcements,
              );
              // Session().saveLatestAnnouncement(state.announcement);
            }
            if (state is NotificationRecieved) {
              if (state.configs != null) {
                BlocProvider.of<EmergencyBloc>(context).add(
                  AnswerIncomingCallEvent(configs: state.configs!),
                );
                if (state.onForeground) {
                  incomingCallNotifCtrl.forward();
                } else {
                  appRouter.pushNamed(
                    Routes.emergency.name,
                    extra: CallDirection.incoming,
                  );
                }
                return;
              } else if (state.configs == null && state.bookingID == null) {
                FlutterRingtonePlayer.stop();
                Vibration.cancel();
                incomingCallNotifCtrl.reverse();
                return;
              }
              if (state.onForeground) {
                notificationCtrl.forward().then((value) {
                  Future.delayed(
                    const Duration(seconds: 5),
                    () => notificationCtrl.reverse(),
                  );
                });
              } else {
                Session().isLoggedIn
                    ? appRouter.pushNamed(Routes.checkoutNotification.name)
                    : appRouter.goNamed(Routes.checkoutNotification.name);
              }
            }
          },
        ),
        BlocListener<BookingBloc, BookingState>(
          listenWhen: (previous, current) => current is CheckoutState,
          listener: (context, state) {
            if (state is CheckedOut) {
              context.goNamed(Routes.trails.name);
            }
          },
        ),
      ],
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.child,
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedBuilder(
              animation: notifAnimation,
              child: NotificationBanner(
                onPressed: () {
                  notificationCtrl.reverse();
                },
              ),
              builder: (context, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(notifAnimation),
                  child: child,
                );
              },
            ),
          ),
          Align(
            alignment: const Alignment(0, .25),
            child: AnimatedBuilder(
              animation: incomingCallAnimation,
              child: IncomingCallNotifDialog(
                incomingCallNotifCtrl: incomingCallNotifCtrl,
              ),
              builder: (context, child) {
                return ScaleTransition(
                  scale: incomingCallAnimation,
                  child: child,
                );
              },
            ),
          ),
          Align(
            alignment: const Alignment(0, 0),
            child: AnimatedBuilder(
              animation: announcementAnimation,
              child: BlocBuilder<NotificationsBloc, NotificationsState>(
                buildWhen: (previous, current) =>
                    current is AnnouncementRecieved,
                builder: (context, state) {
                  if (state is AnnouncementRecieved) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        AbsorbPointer(
                          child: SizedBox.fromSize(
                            size: MediaQuery.of(context).size,
                          ),
                        ),
                        AnnouncementDialog(
                          controller: announcementCtrl,
                          announcement: state.announcements.first,
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              builder: (context, child) {
                return ScaleTransition(
                  scale: announcementAnimation,
                  child: child,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
