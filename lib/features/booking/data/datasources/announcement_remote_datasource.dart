import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/announcement_datasource.dart';

class AnnouncementRemoteDataSource implements AnnouncementDatasource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  AnnouncementRemoteDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<List<dynamic>> getAnnouncements() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    List<dynamic> announcementResult;
    try {
      Response response = await dioClient.get('${environmentConfig.apihost}/announcements?page=1&limit=999999');
      announcementResult = response.data['announcements'] ?? [];
      debugPrint("This is the announcement datasource");
      return announcementResult;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data['message']}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
      return [];
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      return [];
    }
  }
}