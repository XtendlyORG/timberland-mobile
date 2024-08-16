import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/features/session/session_datasource.dart';

class SessionRemoteDataSource implements SessionDatasource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  SessionRemoteDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<dynamic> deviceSubscribe(Map<String, dynamic> reqBody) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    dynamic announcementResult;
    try {
      Response response = await dioClient.post(
        '${environmentConfig.apihost}/announcements/device-subscribe',
        data: reqBody
      );
      announcementResult = response.data;
      debugPrint("This is the announcement datasource device-subscribe");
      return announcementResult;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request device-subscribe!');
        debugPrint(e.message);
      }
      return {};
    } catch (e) {
      debugPrint("Error: device-subscribe ${e.toString()}");
      return {};
    }
  }
}