import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/booking_response.dart';
import '../params/booking_request_params.dart';

abstract class BookingRepository extends Repository {
  Future<Either<BookingFailure, BookingResponse>> submitBookingRequest(
    BookingRequestParams parameter,
  );

  Future<Either<Failure, int>> getFreePassCount();
}
