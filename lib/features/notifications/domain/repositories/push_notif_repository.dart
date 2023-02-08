import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';

abstract class PushNotificationRepository {
  Future<Either<PushNotificationFailure, void>> checkForFCMTokenUpdates();

  Future<Either<PushNotificationFailure, Announcement?>> checkForAnnouncements();
}
