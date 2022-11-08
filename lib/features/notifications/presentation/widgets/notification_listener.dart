import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
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
    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
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
