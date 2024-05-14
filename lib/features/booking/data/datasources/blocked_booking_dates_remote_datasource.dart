import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/blocked_booking_datasource.dart';

class BlockedBookingRemoteDataSource implements BlockedBookingDatasource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  BlockedBookingRemoteDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<List<dynamic>> blockedBookingsRequest() async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    List<dynamic> bookingsResult;
    try {
      Response response = await dioClient.get('${environmentConfig.apihost}/bookings/booking-dates/all');
      bookingsResult = response.data;
      debugPrint("This is the datasource");
      return bookingsResult;
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