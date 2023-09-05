// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';

class PaymentHistory extends History {
  final String id;
  final PaymentStatus status;
  final double amount;
  final DateTime dateCreated;
  final String refNum;
  PaymentHistory({
    required this.id,
    required this.status,
    required this.amount,
    required this.dateCreated,
    required this.refNum,
  });

  factory PaymentHistory.fromMap(Map<String, dynamic> map) {
    return PaymentHistory(
      id: map['payment_id'] as String,
      status: _parseStatus(map['status'] as String),
      amount: double.tryParse(map['amount'] as String) ?? 0,
      refNum: map['ref_number'] as String,
      dateCreated: DateTime.parse(map['created_at'] as String).toLocal(),
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
      case "PAYMENT_EXPIRED":
        return PaymentStatus.expired;
      default:
        throw Exception('INVALID PAYMENT STATUS: $status');
    }
  }
}

enum PaymentStatus {
  successful,
  failed,
  cancelled,
  expired,
}
