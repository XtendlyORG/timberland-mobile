import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/trail.dart';
import '../params/fetch_trails.dart';
import '../params/search_trails.dart';

abstract class TrailRepository extends Repository {
  Future<Either<TrailFailure, List<Trail>>> fetchTrails(
      FetchTrailsParams params);

  Future<Either<TrailFailure, List<Trail>>> searchTrails(
    SearchTrailsParams params,
  );
}
