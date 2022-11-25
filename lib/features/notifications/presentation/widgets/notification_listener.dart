import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';
import 'package:timberland_biketrail/features/emergency/presentation/pages/emergency_page.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/notification_banner.dart';

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
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation curvedAnimation;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EmergencyBloc>(context).add(ConnectToSocket());
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInBack,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            if (state is IncomingCallNotification) {
              BlocProvider.of<EmergencyBloc>(context)
                  .add(AnswerIncomingCallEvent(configs: state.configs));

              // BlocProvider.of<AuthBloc>(context).add(const FetchUserEvent());
              context.pushNamed(
                Routes.emergency.name,
                extra: CallDirection.incoming,
              );
            }
            if (state is NotificationRecieved) {
              if (state.onForeground) {
                controller.forward().then((value) {
                  Future.delayed(
                    const Duration(seconds: 5),
                    () => controller.reverse(),
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
        alignment: Alignment.topCenter,
        children: [
          widget.child,
          AnimatedBuilder(
            animation: curvedAnimation,
            child: NotificationBanner(
              onPressed: () {
                controller.reverse();
              },
            ),
            builder: (context, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              );
            },
          ),
        ],
      ),
    );
  }
}
