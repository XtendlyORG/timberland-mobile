// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Inquiry extends Equatable {
  final String email;
  final String fullName;
  final String subject;
  final String message;
  const Inquiry({
    required this.email,
    required this.fullName,
    required this.subject,
    required this.message,
  });

  @override
  List<Object> get props => [email, fullName, subject, message];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': fullName,
      'subject': subject,
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());
}
