// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/domain/entities/booking_response.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';

class BookingRemoteDataSource implements BookingDatasource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  BookingRemoteDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<BookingResponse> submitBookingRequest(BookingRequestParams params) {
    return this(callback: () async {
      try {
        final result = await dioClient.post(
          '${environmentConfig.apihost}/bookings',
          data: params.toJson(),
        );
        log(result.statusCode.toString());

        if (result.statusCode == 200) {
          if (result.data is Map<String, dynamic>) {
            return BookingResponse.fromMap(result.data);
          }
        }
      } on DioError catch (dioError) {
        if ((dioError.response?.statusCode ?? -1) == 400) {
          if (dioError.response?.data is Map<String, dynamic>) {
            if ((dioError.response?.data['message'] as String) ==
                "Sorry, You already have a completed booking for this day.") {
              throw const DuplicateBookingException(
                message: 'You already have a booking for that date.',
              );
            }
          }
          rethrow;
        }
      }
      throw const BookingException();
    });
  }

  Future<ReturnType> call<ReturnType>({
    required Future<ReturnType> Function() callback,
  }) async {
    try {
      return await callback();
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? 'statuscode: -1');
      log(dioError.response?.data.toString() ?? "no message");

      if ((dioError.response?.statusCode ?? -1) == 400) {
        if (dioError.response?.data.toString() == 'Email is Invalid') {
          throw const BookingException(
            message: 'Email is not verified',
          );
        }
        throw BookingException(
          message:
              dioError.response?.data.toString() ?? 'Something went wrong..',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        log(dioError.response?.data?.toString() ?? "No error message: 502");
        throw const BookingException(
          message: 'Internal Server Error',
        );
      }
      throw const BookingException(
        message: "Error Occurred",
      );
    } on DuplicateBookingException {
      rethrow;
    } on BookingException{
      rethrow;
    } 
    catch (e) {
      log(e.toString());
      throw const BookingException(message: "An Error Occurred");
    }
  }
}
