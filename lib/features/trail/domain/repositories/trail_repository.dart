import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';

abstract class TrailRepository extends Repository {
  Future<Either<Failure, List<Trail>>> fetchTrails();
}
