import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/features/booking/domain/params/create_booking_params.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../params/booking_request_params.dart';

abstract class BookingRepository extends Repository {
  Future<Either<BookingFailure, String>> submitBookingRequest(
    BookingRequestParams requestParams,
  );
  Future<Either<BookingFailure, void>> createBooking(
    CreateBookingParameter parameter,
  );
}
