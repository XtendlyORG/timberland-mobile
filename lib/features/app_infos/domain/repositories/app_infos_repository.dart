import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/inquiry.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/faq.dart';
import '../entities/trail_rule.dart';

abstract class AppInfoRepository extends Repository {
  Future<Either<AppInfoFailure, List<TrailRule>>> fetchTrailRules();
  Future<Either<AppInfoFailure, List<FAQ>>> fetchFAQs();
  Future<Either<AppInfoFailure, void>> sendInquiry(Inquiry inquiry);
}
