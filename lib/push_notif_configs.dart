import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timberland_biketrail/dependency_injection/app_info_depencency.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/firebase_options.dart';

Future<void> initFirebaseMessaging() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    announcement: false,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
  );

  // Notification callback while app is open (foreground)
  FirebaseMessaging.onMessage.listen((event) {
    if (event.notification != null) {
      serviceLocator<NotificationsBloc>().add(NotificationRecievedEvent());
    } else {
      log('Message has no notification');
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null && value.notification != null) {
      serviceLocator<NotificationsBloc>().add(NotificationOnBackground());
    }
  });

  // When banner notif is pressed
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    serviceLocator<NotificationsBloc>().add(NotificationOnBackground());
  });

  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
}

Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
