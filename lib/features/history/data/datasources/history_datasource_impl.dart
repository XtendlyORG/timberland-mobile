// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/utils/session.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/booking_history.dart';
import '../../domain/entities/payment_history.dart';
import 'history_datasource.dart';

class HistoryDataSoureImpl implements HistoryDataSoure {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  HistoryDataSoureImpl({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<List<BookingHistory>> fetchBookingHistory() {
    return this(callback: () async {
      final response = await dioClient.get(
        '${environmentConfig.apihost}/bookings/${Session().currentUser!.id}/history',
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        return response.data!
            .map<BookingHistory>(
              (data) => BookingHistory.fromMap(data),
            )
            .toList();
      }
      if (response.data is List) {
        return [];
      }
      throw const HistoryException(message: 'Failed to retrieve bookings');
    });
  }

  @override
  Future<List<PaymentHistory>> fetchPaymentHistory() {
    return this(callback: () async {
      final response = await dioClient.get(
        '${environmentConfig.apihost}/payments/${Session().currentUser!.id}/history',
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        return response.data!
            .map<PaymentHistory>(
              (data) => PaymentHistory.fromMap(data),
            )
            .toList();
      }
      if (response.data is List) {
        return [];
      }
      throw const HistoryException(message: 'Failed to retrieve payments');
    });
  }

  @override
  Future<void> cancelBooking(String bookingId, String reason) {
    return this(callback: () async {
      final response = await dioClient.post(
        '${environmentConfig.apihost}/bookings/$bookingId/cancel',
        options: Options(
          validateStatus: (status) => true,
        ),
        data: {"reason": reason},
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        return;
      }
      log(response.data.toString());
      throw const HistoryException(message: 'Failed to retrieve payments');
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
        throw HistoryException(
          message:
              dioError.response?.data.toString() ?? 'Something went wrong..',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        log(dioError.response?.data?.toString() ?? "No error message: 502");
        throw const HistoryException(
          message: 'Internal Server Error',
        );
      }
      throw const HistoryException(
        message: "Error Occurred",
      );
    } on HistoryException {
      rethrow;
    } catch (e) {
      if (e is HistoryException) {
        log(e.message ?? 'no message');
      }
      log(e.toString());
      throw const HistoryException(message: "An Error Occurred");
    }
  }
}
