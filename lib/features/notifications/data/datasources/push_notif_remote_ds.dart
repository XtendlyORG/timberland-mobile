// // Fetch FCM Token
// FirebaseMessaging.instance.getToken().then((value) async {
//   if (value != null) {
//     if (value != (Session().getFCMToken() ?? '')) {
//       try {
//         final dio = di.serviceLocator<Dio>();
//         final result = await dio.put(
//           '${di.serviceLocator<EnvironmentConfig>().apihost}/api/send-notification',
//           data: {
//             'fcm_token': value,
//           },
//         );
//         if (result.statusCode == 200) {
//           log(result.data.toString());
//         }
//       } on DioError catch (dioError) {
//         log(dioError.toString());
//       }
//     }
//     log(name: 'FCM_TOKEN', value);
//   } else {
//     log(error: 'FCM_TOKEN', 'NO TOKEN FETCHED');
//   }
// });

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/notifications/data/datasources/push_notif_ds.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';

import '../../../../core/configs/environment_configs.dart';

class PushNotificationRemoteDataSourceImpl
    implements PushNotificationRemoteDataSource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;

  PushNotificationRemoteDataSourceImpl({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<void> updateToken(String memberId, String token) async {
    try {
      final response = await dioClient.put(
        '${environmentConfig.apihost}/members/$memberId/notification-token',
        data: {'token': token},
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        return;
      }
    } on DioError catch (e) {
      throw PushNotificationException(message: e.message);
    }
  }

  @override
  Future<Announcement?> fetchLatestAnnouncement() async {
    try {
      final response = await dioClient.get(
        '${environmentConfig.apihost}/announcements/latest',
      );

      if (response.statusCode == 200) {
        return response.data == null
            ? null
            : Announcement.fromMap(response.data);
      }
      throw const PushNotificationException(
        message: 'Something went wrong.',
      );
    } on DioError catch (e) {
      throw PushNotificationException(message: e.message);
    } catch (e) {
      throw PushNotificationException(
        message:
            'Something went wrong${kDebugMode ? ': ${e.toString()}' : '.'}',
      );
    }
  }
}
