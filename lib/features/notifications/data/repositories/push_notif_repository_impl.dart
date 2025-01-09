// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/notifications/data/datasources/push_notif_ds.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';
import 'package:timberland_biketrail/features/notifications/domain/repositories/push_notif_repository.dart';

class PushNotificationRepositoryImpl implements PushNotificationRepository {
  final PushNotificationRemoteDataSource remoteDataSource;
  PushNotificationRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Future<Either<PushNotificationFailure, void>>
      checkForFCMTokenUpdates() async {
    return this(
      callback: () async {
        FirebaseMessaging.instance.getToken().then((value) async {
          return; // Firebase not working in iOS
          if (value != null) {
            if (value == (Session().getFCMToken() ?? '')) {
              return;
            }
            remoteDataSource.updateToken(
              Session().currentUser!.id,
              value,
            );
          }
        });
      },
    );
  }

  @override
  Future<Either<PushNotificationFailure, List<Announcement>?>>
      checkForAnnouncements() {
    return this(
      callback: () => remoteDataSource.fetchLatestAnnouncement(),
    );
  }

  Future<Either<PushNotificationFailure, T>> call<T>({
    required Future<T> Function() callback,
  }) async {
    try {
      return Right(await callback());
    } on PushNotificationException catch (e) {
      return Left(
        PushNotificationFailure(message: e.message ?? 'Something went wrong.'),
      );
    } catch (e) {
      return Left(PushNotificationFailure(message: e.toString()));
    }
  }
}
