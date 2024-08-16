import 'package:timberland_biketrail/core/utils/repository.dart';

abstract class SessionRepository extends Repository {
  Future<dynamic> deviceSubscribe(Map<String, dynamic> reqBody);
}