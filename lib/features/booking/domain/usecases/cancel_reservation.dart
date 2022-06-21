// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

class CancelReservation implements Usecase<void, void> {
  @override
  final BookingRepository repository;
  CancelReservation({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(void params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
