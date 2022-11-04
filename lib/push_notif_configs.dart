import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
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
      showInfo(event.data.toString());
    } else {
      log('Message has no notification');
    }
  });

  FirebaseMessaging.instance.getInitialMessage().then((value) {
    if (value != null && value.notification != null) {
      appRouter.goNamed(Routes.checkoutNotification.name);
    }
  });

  // When banner notif is pressed
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Session().isLoggedIn
        ? appRouter.pushNamed(Routes.checkoutNotification.name)
        : appRouter.goNamed(Routes.checkoutNotification.name);
  });

  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
}

Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
