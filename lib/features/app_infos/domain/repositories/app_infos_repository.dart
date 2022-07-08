import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

abstract class AppInfoRepository extends Repository {
  Future<Either<AppInfoFailure, List<TrailRule>>> fetchTrailRules();
}
