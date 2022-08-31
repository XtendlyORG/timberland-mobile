// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookingRequestParams extends Equatable {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String date;
  final String time;
  const BookingRequestParams({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.date,
    required this.time,
  });

  @override
  List<Object> get props {
    return [
      lastName,
      mobileNumber,
      email,
      date,
      time,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstName,
      'lastname': lastName,
      'mobile_number': mobileNumber,
      'email': email,
      'date': date,
      'time': time,
    };
  }

  String toJson() => json.encode(toMap());
}
