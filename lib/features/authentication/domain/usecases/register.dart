// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class Register implements Usecase<User, RegisterParameter> {
  @override
  final AuthRepository repository;

  const Register({required this.repository});

  @override
  Future<Either<Failure, User>> call(params) {
    return repository.register(params);
  }
}

class RegisterParameter {
  //TODO: Fields may change
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  RegisterParameter({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}
