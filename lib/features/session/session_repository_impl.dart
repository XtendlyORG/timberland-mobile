import 'package:flutter/foundation.dart';
import 'package:timberland_biketrail/features/session/session_datasource.dart';
import 'package:timberland_biketrail/features/session/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionDatasource sessionDatasource;
  SessionRepositoryImpl({
    required this.sessionDatasource,
  });

  @override
  Future<dynamic> deviceSubscribe(Map<String, dynamic> reqBody) async {
    try {
      final result = await sessionDatasource.deviceSubscribe(reqBody);
      debugPrint("This is the repository");
      return result;
    } catch (e) {
      debugPrint(e.toString());
      return "Error: Failed to load device subscribe";
    }
  }
}