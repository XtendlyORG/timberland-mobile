import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';

abstract class EmergencyRepository extends Repository{
  Future<Either<EmergencyFailure, EmergencyConfigs>> fetchToken(String channelID);
}