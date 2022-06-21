import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/booking/domain/entities/booking.dart';
import 'package:timberland_biketrail/features/booking/domain/usecases/place_reservation.dart';

abstract class BookingRepository extends Repository {
  Future<Either<Failure, Booking>> placeBooking(
    BookingReservationParams reservationParams,
  );
  Future<Either<Failure, void>> cancelBooking();
}
