// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/booking/domain/entities/booking.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

class PlaceReservation implements Usecase<Booking, BookingReservationParams> {
  @override
  final BookingRepository repository;
  PlaceReservation({
    required this.repository,
  });

  @override
  Future<Either<Failure, Booking>> call(
      BookingReservationParams reservationParams) {
    return repository.placeBooking(reservationParams);
  }
}

class BookingReservationParams {}
