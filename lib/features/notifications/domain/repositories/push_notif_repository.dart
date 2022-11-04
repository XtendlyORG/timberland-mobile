import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';

abstract class PushNotificationRepository {
  Future<Either<PushNotificationFailure, void>> checkForFCMTokenUpdates();
}
