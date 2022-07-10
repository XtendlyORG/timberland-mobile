// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';

class FetchTrails implements Usecase<List<Trail>, FetchTrailsParams> {
  @override
  final TrailRepository repository;
  const FetchTrails({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Trail>>> call(
      FetchTrailsParams fetchTrailsParams) {
    return repository.fetchTrails(fetchTrailsParams);
  }
}

class FetchTrailsParams {}
