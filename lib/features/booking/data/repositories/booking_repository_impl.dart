// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/domain/entities/booking.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';
import 'package:timberland_biketrail/features/booking/domain/usecases/place_reservation.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingDatasource bookingDatasource;
  BookingRepositoryImpl({
    required this.bookingDatasource,
  });

  @override
  Future<Either<BookingFailure, void>> cancelBooking() {
    // TODO: implement cancelBooking
    throw UnimplementedError();
  }

  @override
  Future<Either<BookingFailure, Booking>> placeBooking(
    BookingReservationParams reservationParams,
  ) {
    // TODO: implement placeBooking
    throw UnimplementedError();
  }

  @override
  Future<Either<BookingFailure, String>> submitBookingRequest() async {
    try {
      return Right(await bookingDatasource.submitBookingRequest());
    } on BookingException catch (e) {
      return Left(
        BookingFailure(message: e.message ?? "Failed to submit booking."),
      );
    }
  }
}
