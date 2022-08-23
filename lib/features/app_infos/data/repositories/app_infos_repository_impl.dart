// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/inquiry.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';
import 'package:timberland_biketrail/features/app_infos/domain/repositories/app_infos_repository.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final AppInfoDataSource remoteDatasource;
  const AppInfoRepositoryImpl({
    required this.remoteDatasource,
  });
  @override
  Future<Either<AppInfoFailure, List<TrailRule>>> fetchTrailRules() async {
    try {
      return Right(await remoteDatasource.fetchTrailRules());
    } on AppInfoException catch (e) {
      return Left(
        AppInfoFailure(message: e.message ?? "Failed to fetch trail rules."),
      );
    }
  }

  @override
  Future<Either<AppInfoFailure, List<FAQ>>> fetchFAQs() async {
    try {
      return Right(await remoteDatasource.fetchFAQs());
    } on AppInfoException catch (e) {
      return Left(
        AppInfoFailure(message: e.message ?? "Failed to fetch FAQs."),
      );
    }
  }

  @override
  Future<Either<AppInfoFailure, void>> sendInquiry(Inquiry inquiry) async {
    try {
      return Right(await remoteDatasource.sendInquiry(inquiry));
    } on AppInfoException catch (e) {
      return Left(
        AppInfoFailure(message: e.message ?? "Failed to send your message."),
      );
    }
  }
}
