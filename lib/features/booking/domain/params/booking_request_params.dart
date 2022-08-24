// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookingRequestParams extends Equatable {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String customerFullname;
  final String mobileNumber;
  final String email;
  final String date;
  final String time;
  const BookingRequestParams({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.customerFullname,
    required this.mobileNumber,
    required this.email,
    required this.date,
    required this.time,
  });

  @override
  List<Object> get props => [
        firstName,
        if (middleName != null) middleName!,
        lastName,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstName,
      'middlename': middleName,
      'lastname': lastName,
    };
  }

  String toJson() => json.encode(toMap());
}
