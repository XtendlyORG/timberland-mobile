// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/domain/params/create_booking_params.dart';

class BookingRemoteDataSource implements BookingDatasource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  BookingRemoteDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<String> submitBookingRequest(BookingRequestParams params) {
    return this(callback: () async {
      log('test');
      final result = await dioClient.post(
        '${environmentConfig.apihost}/payments/create-checkout-session',
        data: params.toJson(),
      );

      if (result.statusCode == 200) {
        if (result.data is Map<String, dynamic>) {
          return result.data['redirectUrl'];
        }
      }
      throw const BookingException();
    });
  }

  @override
  Future<void> createBooking(CreateBookingParameter params) {
    return this(callback: () async {
      final result = await dioClient.post(
        '${environmentConfig.apihost}/bookings/',
        data: params.toJson(),
      );

      if (result.statusCode == 200) {
        return;
      } else {
        throw const BookingException();
      }
    });
  }

  Future<ReturnType> call<ReturnType>({
    required Future<ReturnType> Function() callback,
  }) async {
    try {
      return await callback();
    } on DioError catch (error) {
      log(error.toString());
      log(error.response?.data ?? '');
      throw const BookingException();
    } catch (e) {
      throw const BookingException();
    }
  }
}
