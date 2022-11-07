// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class Inquiry extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String subject;
  final String message;
  final List<File> images;
  const Inquiry({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.subject,
    required this.message,
    required this.images,
  });

  @override
  List<Object> get props => [
        email,
        firstName,
        lastName,
        subject,
        message,
        images,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'firstname': firstName,
      'lastname': lastName,
      'subject': subject,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());
}
