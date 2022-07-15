// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';
import 'package:timberland_biketrail/features/app_infos/domain/repositories/app_infos_repository.dart';

class FetchTrailRules implements Usecase<List<TrailRule>, void> {
  @override
  final AppInfoRepository repository;
  const FetchTrailRules({
    required this.repository,
  });
  @override
  Future<Either<AppInfoFailure, List<TrailRule>>> call(void params) {
    return repository.fetchTrailRules();
  }
}
