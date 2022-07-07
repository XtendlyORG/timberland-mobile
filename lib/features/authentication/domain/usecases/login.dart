// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class Login implements Usecase<User, LoginParameter> {
  @override
  final AuthRepository repository;

  const Login({required this.repository});

  @override
  Future<Either<AuthFailure, User>> call(params) {
    return repository.login(params);
  }
}

class LoginParameter {
  //TODO: Fields may change
  final String email;
  final String password;
  LoginParameter({
    required this.email,
    required this.password,
  });
}
