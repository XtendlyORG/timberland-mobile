// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
  const BookingHistory({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.time,
    required this.date,
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
    );
  }
}
