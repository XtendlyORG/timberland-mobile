import '../../domain/entities/faq.dart';
import '../../domain/entities/inquiry.dart';
import '../../domain/entities/trail_rule.dart';

abstract class RemoteDatasource {
  Future<List<TrailRule>> fetchTrailRules();
  Future<List<FAQ>> fetchFAQs();
  Future<void> sendInquiry(Inquiry inquiry);
}
