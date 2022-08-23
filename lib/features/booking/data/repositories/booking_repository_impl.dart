// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDatasource bookingDatasource;
  BookingRepositoryImpl({
    required this.bookingDatasource,
  });

  @override
  Future<Either<BookingFailure, String>> submitBookingRequest(
      BookingRequestParams requestParams) async {
    try {
      return Right(await bookingDatasource.submitBookingRequest(requestParams));
    } on BookingException catch (e) {
      return Left(
        BookingFailure(message: e.message ?? "Failed to submit booking."),
      );
    }
  }
}
