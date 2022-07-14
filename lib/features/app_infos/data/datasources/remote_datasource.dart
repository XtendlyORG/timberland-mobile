import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

abstract class RemoteDatasource {
  Future<List<TrailRule>> fetchTrailRules();
  Future<List<FAQ>> fetchFAQs();
}
