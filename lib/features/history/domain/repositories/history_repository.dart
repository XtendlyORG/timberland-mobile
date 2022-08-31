import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/entities.dart';

abstract class HistoryRepository {
  Future<Either<HistoryFailure, List<PaymentHistory>>> fetchPaymentHistory();
  Future<Either<HistoryFailure, List<BookingHistory>>> fetchBookingHistory();
}
