// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/features/history/data/datasources/history_datasource.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/booking_history.dart';
import '../../domain/entities/payment_history.dart';
import '../../domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSoure dataSource;
  HistoryRepositoryImpl({
    required this.dataSource,
  });
  @override
  Future<Either<HistoryFailure, List<BookingHistory>>> fetchBookingHistory() {
    return this(request: dataSource.fetchBookingHistory);
  }

  @override
  Future<Either<HistoryFailure, List<PaymentHistory>>> fetchPaymentHistory() {
    return this(request: dataSource.fetchPaymentHistory);
  }

  @override
  Future<Either<HistoryFailure, void>> cancelBooking(
      String bookingId, String reason) {
    return this(
      request: () => dataSource.cancelBooking(bookingId, reason),
    );
  }

  Future<Either<HistoryFailure, ReturnType>> call<ReturnType>({
    required Future<ReturnType> Function() request,
  }) async {
    try {
      return Right(await request());
    } on HistoryException catch (exception) {
      return Left(
        HistoryFailure(
          message: exception.message ?? 'Server Failure.',
        ),
      );
    } catch (e) {
      return const Left(
        HistoryFailure(
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
