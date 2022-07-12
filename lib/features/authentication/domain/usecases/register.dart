// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class Register implements Usecase<User, RegisterParameter> {
  @override
  final AuthRepository repository;

  const Register({required this.repository});

  @override
  Future<Either<AuthFailure, User>> call(params) {
    return repository.register(params);
  }
}

class RegisterParameter extends Equatable {
  final String? otp;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  const RegisterParameter({
    this.otp,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props {
    return [
      if (otp != null) otp!,
      firstName,
      lastName,
      email,
      password,
    ];
  }

  RegisterParameter copyWith({
    String? otp,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) {
    return RegisterParameter(
      otp: otp ?? this.otp,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
