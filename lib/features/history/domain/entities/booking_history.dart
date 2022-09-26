// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/format_time.dart';
import 'package:timberland_biketrail/features/history/domain/entities/history.dart';

class BookingHistory extends History {
  final String id;
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final TimeOfDay time;
  final DateTime date;
  final BookingStatus status;
  const BookingHistory({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.time,
    required this.date,
    required this.status,
  });

  factory BookingHistory.fromMap(Map<String, dynamic> map) {
    return BookingHistory(
      id: map['booking_id'].toString(),
      firstName: map['firstname'] as String,
      lastName: map['lastname'] as String,
      mobileNumber: map['mobile_number'] as String,
      email: map['email'] as String,
      time: stringToTime(map['time']),
      date: DateTime.parse(map['date'] as String),
      status: _status[map['status'] as String] ?? BookingStatus.undefined,
    );
  }

  BookingHistory copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? mobileNumber,
    String? email,
    TimeOfDay? time,
    DateTime? date,
    BookingStatus? status,
  }) {
    return BookingHistory(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      time: time ?? this.time,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}

const Map<String, BookingStatus> _status = {
  'Paid': BookingStatus.paid,
  'Checked In': BookingStatus.onGoing,
  'Cancelled': BookingStatus.cancelled,
  'Not Paid': BookingStatus.notPaid,
  'Free Pass': BookingStatus.free,
  'Checked Out': BookingStatus.done,
};

enum BookingStatus {
  paid(
    status: "Paid",
    color: TimberlandColor.accentColor,
  ),
  onGoing(
    status: "Checked In",
    color: TimberlandColor.primary,
  ),
  cancelled(
    status: "Cancelled",
    color: TimberlandColor.orange,
  ),
  notPaid(
    status: 'Not Paid',
    color: TimberlandColor.secondaryColor,
  ),
  free(
    status: 'Free',
    color: TimberlandColor.accentColor,
  ),
  done(
    status: 'Checked Out',
    color: TimberlandColor.primary,
  ),
  undefined(
    status: 'Undefined',
    color: TimberlandColor.subtext,
  );

  final String status;
  final Color color;
  const BookingStatus({required this.status, required this.color});
}
