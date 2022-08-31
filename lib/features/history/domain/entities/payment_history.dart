// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';

class PaymentHistory extends History {
  final String id;
  final PaymentStatus status;
  final double amount;
  final DateTime dateCreated;
  PaymentHistory({
    required this.id,
    required this.status,
    required this.amount,
    required this.dateCreated,
  });

  factory PaymentHistory.fromMap(Map<String, dynamic> map) {
    return PaymentHistory(
      id: map['payment_id'] as String,
      status: _parseStatus(map['status'] as String),
      amount: double.tryParse(map['amount'] as String) ?? 0,
      dateCreated: DateTime.parse(map['created_at'] as String),
    );
  }

  static PaymentStatus _parseStatus(String status) {
    switch (status) {
      case "PAYMENT_SUCCESS":
        return PaymentStatus.successful;
      case "PAYMENT_FAILED":
        return PaymentStatus.failed;
      case "PAYMENT_CANCELED":
        return PaymentStatus.cancelled;
      default:
        throw Exception('INVALID PAYMENT STATUS: $status');
    }
  }
}

enum PaymentStatus {
  successful,
  failed,
  cancelled,
}
