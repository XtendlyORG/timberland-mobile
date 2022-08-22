// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

abstract class Failure {}

class AuthFailure implements Failure {
  final String message;

  const AuthFailure({required this.message});
}

class UnverifiedEmailFailure extends AuthFailure {
  const UnverifiedEmailFailure({required super.message});
}

class AppInfoFailure implements Failure {
  final String message;
  const AppInfoFailure({
    required this.message,
  });
}

class TrailFailure implements Failure {
  final String message;
  const TrailFailure({
    required this.message,
  });
}

class ProfileFailure implements Failure {
  final String message;
  const ProfileFailure({
    required this.message,
  });
}

class BookingFailure implements Failure {
  final String message;
  const BookingFailure({
    required this.message,
  });
}
