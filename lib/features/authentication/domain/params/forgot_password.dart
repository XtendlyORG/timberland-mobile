// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class VerifyOTPParameter extends Equatable {
  final String email;
  final String otp;
  const VerifyOTPParameter({
    required this.email,
    required this.otp,
  });

  @override
  List<Object> get props => [email, otp];
}

class ResetPasswordParameter extends Equatable {
  final String email;
  final String password;
  const ResetPasswordParameter({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
