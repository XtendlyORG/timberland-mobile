// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';

class BookingRemoteDataSource implements BookingDatasource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  BookingRemoteDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<String> submitBookingRequest() async {
    try {
      final result = await dioClient.post(
        '${environmentConfig.apihost}/payments/create-checkout-session',
      );

      log(result.statusCode.toString());
      log(result.data.toString());

      return result.data.toString();
    } on DioError catch (error) {
      log(error.toString());
      throw BookingException();
    } catch (e) {
      throw BookingException();
    }
  }
}
