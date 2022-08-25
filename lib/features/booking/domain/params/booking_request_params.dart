// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BookingRequestParams extends Equatable {
  final String firstName;
  final String? middleName;
  final String lastName;
  const BookingRequestParams({
    required this.firstName,
    this.middleName,
    required this.lastName,
  });

  @override
  List<Object> get props => [
        firstName,
        if (middleName != null) middleName!,
        lastName,
      ];

  BookingRequestParams copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
  }) {
    return BookingRequestParams(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstName,
      'middlename': middleName,
      'lastname': lastName,
    };
  }

  String toJson() => json.encode(toMap());
}
