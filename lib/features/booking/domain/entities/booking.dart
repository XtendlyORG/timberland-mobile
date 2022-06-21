// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Booking extends Equatable {
  final String bookingId;
  final DateTime bookDate;
  final String serviceId;
  final String userId;
  final String status;
  const Booking({
    required this.bookingId,
    required this.bookDate,
    required this.serviceId,
    required this.userId,
    required this.status,
  });

  @override
  List<Object?> get props => [
        bookingId,
        bookDate,
        serviceId,
        userId,
        status,
      ];
}
