// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/notifications/data/datasources/push_notif_ds.dart';
import 'package:timberland_biketrail/features/notifications/domain/repositories/push_notif_repository.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  final PushNotificationRemoteDataSource remoteDataSource;
  PushNotificationRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<PushNotificationFailure, void>>
      checkForFCMTokenUpdates() async {
    try {
      FirebaseMessaging.instance.getToken().then((value) async {
        if (value != null) {
          log(name: 'FCM_TOKEN', value);
          if (value == (Session().getFCMToken() ?? '')) {
            return;
          }
          remoteDataSource.updateToken(
            Session().currentUser!.id,
            value,
          );
        }
      });
      return const Right(null);
    } catch (e) {
      return Left(PushNotificationFailure(message: e.toString()));
    }
  }
}
