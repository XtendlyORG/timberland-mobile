import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/booking.dart';
import '../usecases/place_reservation.dart';

abstract class BookingRepository extends Repository {
  Future<Either<BookingFailure, Booking>> placeBooking(
    BookingReservationParams reservationParams,
  );
  Future<Either<BookingFailure, void>> cancelBooking();

  Future<Either<BookingFailure, void>> submitBookingRequest();
}
