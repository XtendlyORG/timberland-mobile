import '../../domain/entities/entities.dart';

abstract class HistoryDataSoure {
  Future<List<PaymentHistory>> fetchPaymentHistory();
  Future<List<BookingHistory>> fetchBookingHistory();
}
