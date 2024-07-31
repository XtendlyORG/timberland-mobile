import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timberland_biketrail/core/utils/internet_connection.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:vibration/vibration.dart';

Future<void> initFirebaseMessaging() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  final messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    announcement: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
  );
  messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Notification callback while app is open (foreground)
  FirebaseMessaging.onMessage.listen((event) async {
    debugPrint("Trigger firebase event ${event.data.toString()} ${event.notification?.title}");

    if(event.data['title'].toString() != "null"){
      log('Firebase notifs ${event.data['title']} ${event.data['content']}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firebase-notif-id', event.data['id'] ?? 'Announcement!');
      await prefs.setString('firebase-notif-title', event.data['title'] ?? 'Announcement!');
      await prefs.setString('firebase-notif-content', event.data['content'] ?? "Timberland Mountain Bike Park Announcement. You've received a new notification Tap to view");
      return;
    }

    // Announcement Handler
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    // FlutterLocalNotificationsPlugin();
    // FirebaseMessaging messaging = FirebaseMessaging.instance;

    // const AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails('your channel id', 'your channel name',
    //         channelDescription: 'your channel description',
    //         importance: Importance.max,
    //         priority: Priority.high,
    //         ticker: 'ticker');
    // const NotificationDetails notificationDetails =
    //     NotificationDetails(android: androidNotificationDetails);
    // await flutterLocalNotificationsPlugin.show(
    //     DateTime.now().millisecondsSinceEpoch,
    //     "Timberland Mountain Bike Park",
    //     "Timberland Mountain Bike Park Announcement. You've received a new notification Tap to view (Firebase test)",
    //     notificationDetails,
    //     payload: 'item x');
    
    // Incoming Call Handler
    if (Session().currentUser == null) return;
    if (event.notification != null) {
      if ((event.data['member_id'] as String? ?? '') !=
          Session().currentUser!.id) {
        return;
      }
      EmergencyConfigs? configs;
      String? bookingID;
      if (event.data['booking_id'] != null) {
        bookingID = event.data['booking_id'].toString();
      } else {
        bookingID = null;
      }
      if (event.data['token'] != null) {
        _callAlarm();
        try {
          configs = EmergencyConfigs(
            token: event.data['token'] as String,
            channelID: event.data['channel'] as String,
            uid: int.parse(event.data['uid'] as String),
            emergencyId: -1,
          );
        } catch (e) {
          log('Failed to convert data to emergency configs model');
          log(e.toString());

          FlutterRingtonePlayer.stop();
          Vibration.cancel();
        }
      } else {
        configs = null;
      }

      serviceLocator<NotificationsBloc>().add(NotificationRecievedEvent(
        onForeground: true,
        configs: configs,
        bookingID: bookingID,
      ));
    } else {
      log('Message has no notification');
    }
  });

// When app is opened from a terminated state
  FirebaseMessaging.instance.getInitialMessage().then((value) async {
    debugPrint("Trigger firebase value ${value?.data.toString()}");
    
    // Announcement Handler
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch,
        value?.notification?.title ?? "Timberland Mountain Bike Park",
        value?.notification?.body ?? "Timberland Mountain Bike Park Announcement. You've received a new notification.",
        notificationDetails,
        payload: 'item x');

    // Incoming Call Handler
    if (Session().currentUser == null) return;
    if (value != null && value.notification != null) {
      if ((value.data['member_id'] as String? ?? '') !=
          Session().currentUser!.id) {
        return;
      }
      EmergencyConfigs? configs;
      String? bookingID;
      if (value.data['booking_id'] != null) {
        bookingID = value.data['booking_id'].toString();
      } else {
        bookingID = null;
      }
      if (value.data['token'] != null) {
        _callAlarm();
        try {
          configs = EmergencyConfigs(
            token: value.data['token'] as String,
            channelID: value.data['channel'] as String,
            uid: int.parse(value.data['uid'] as String),
            emergencyId: -1,
          );
        } catch (e) {
          log('Failed to convert data to emergency configs model');
          log(e.toString());

          FlutterRingtonePlayer.stop();
          Vibration.cancel();
        }
      } else {
        configs = null;
      }

      serviceLocator<NotificationsBloc>().add(NotificationRecievedEvent(
        onForeground: false,
        configs: configs,
        bookingID: bookingID,
      ));
    }
  });

  // When app is opened from a background state (not terminated)
  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    debugPrint("Trigger firebase open event ${event.data.toString()}");

    if(event.data['title'].toString() != "null"){
      log('Firebase notifs ${event.data['title']} ${event.data['content']}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('firebase-notif-id', event.data['id'] ?? 'Announcement!');
      await prefs.setString('firebase-notif-title', event.data['title'] ?? 'Announcement!');
      await prefs.setString('firebase-notif-content', event.data['content'] ?? "Timberland Mountain Bike Park Announcement. You've received a new notification.");
      return;
    }

    // Announcement Handler
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch,
        event.notification?.title ?? "Timberland Mountain Bike Park",
        event.notification?.body ?? "Timberland Mountain Bike Park Announcement. You've received a new notification.",
        notificationDetails,
        payload: 'item x');

    // Incoming Call Handler
    if (Session().currentUser == null) return;
    if ((event.data['member_id'] as String? ?? '') !=
        Session().currentUser!.id) {
      return;
    }
    EmergencyConfigs? configs;
    String? bookingID;
    if (event.data['booking_id'] != null) {
      bookingID = event.data['booking_id'].toString();
    } else {
      bookingID = null;
    }
    if (event.data['token'] != null) {
      _callAlarm();
      try {
        configs = EmergencyConfigs(
          token: event.data['token'] as String,
          channelID: event.data['channel'] as String,
          uid: int.parse(event.data['uid'] as String),
          emergencyId: -1,
        );
      } catch (e) {
        log('Failed to convert data to emergency configs model');
        log(e.toString());

        FlutterRingtonePlayer.stop();
        Vibration.cancel();
      }
    } else {
      configs = null;
    }

    serviceLocator<NotificationsBloc>().add(NotificationRecievedEvent(
      onForeground: false,
      configs: configs,
      bookingID: bookingID,
    ));
  });

  // When app is in the background (terminated or not)
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessageHandler);
}

Future<void> _onBackgroundMessageHandler(RemoteMessage message) async {
  debugPrint("Trigger firebase back ${message.data.toString()}");

  // Announcement Handler
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch,
      message.notification?.title ?? "Timberland Mountain Bike Park",
      message.notification?.body ?? "Timberland Mountain Bike Park Announcement. You've received a new notification.",
      notificationDetails,
      payload: 'item x');

  // Incoming Call Handler
  if (Session().currentUser == null) return;
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();

  await Session().init();
  await InternetConnectivity().init();

  if ((message.data['member_id'] as String? ?? '') !=
      Session().currentUser!.id) {
    return;
  }

  if (message.data['token'] != null) {
    _callAlarm();
  }
}

void _callAlarm() {
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
}
