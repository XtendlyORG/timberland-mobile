import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../params/booking_request_params.dart';

abstract class BookingRepository extends Repository {
  Future<Either<BookingFailure, String>> submitBookingRequest(
    BookingRequestParams parameter,
  );
}
