import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/booking.dart';
import '../usecases/place_reservation.dart';

abstract class BookingRepository extends Repository {
  Future<Either<Failure, Booking>> placeBooking(
    BookingReservationParams reservationParams,
  );
  Future<Either<Failure, void>> cancelBooking();
}
