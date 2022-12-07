// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/trail/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';

class TrailRepositoryImpl implements TrailRepository {
  final RemoteDatasource remoteDatasource;
  const TrailRepositoryImpl({
    required this.remoteDatasource,
  });
  @override
  Future<Either<TrailFailure, List<Trail>>> fetchTrails(
      FetchTrailsParams params) async {
    try {
      return Right(await remoteDatasource.searchTrails(
        const SearchTrailsParams(name: '', difficulties: []),
      ));
    } on TrailException catch (e) {
      return Left(TrailFailure(message: e.message ?? "Failed to load trails."));
    }
  }

  @override
  Future<Either<TrailFailure, List<Trail>>> searchTrails(
      SearchTrailsParams params) async {
    try {
      return Right(await remoteDatasource.searchTrails(params));
    } on TrailException catch (e) {
      return Left(TrailFailure(message: e.message ?? "Trail Search Failed."));
    }
  }
}
