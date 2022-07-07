// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  //TODO: Fields may change
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  final String accessCode;
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    required this.accessCode,
  });

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      age,
      accessCode,
    ];
  }
}
