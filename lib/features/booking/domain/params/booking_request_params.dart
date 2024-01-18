// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:http_parser/http_parser.dart';

class BookingRequestParams extends Equatable {
  final String firstName;
  final String lastName;
  final String mobileNumber;
  final String email;
  final String date;
  final String time;
  Uint8List? signature;

  BookingRequestParams({
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.email,
    required this.date,
    required this.time,
    this.signature,
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
      'signature': MultipartFile.fromBytes(
        signature!,
        filename: 'signature.png',
        contentType: MediaType('image', 'png'),
      ),
    };
  }

  String toJson() => json.encode(toMap());
}
