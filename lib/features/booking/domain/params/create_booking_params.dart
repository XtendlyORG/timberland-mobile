// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateBookingParameter extends Equatable {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String date;
  final String time;
  const CreateBookingParameter({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.date,
    required this.time,
  });

  @override
  List<Object> get props {
    return [
      fullName,
      mobileNumber,
      email,
      date,
      time,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullName,
      'mobile_number': mobileNumber,
      'email': email,
      'date': date,
      'time': time,
    };
  }

  String toJson() => json.encode(toMap());
}
