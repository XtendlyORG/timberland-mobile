// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class ForgotPassword implements Usecase<void, ForgotPasswordParams> {
  @override
  final AuthRepository repository;
  ForgotPassword({
    required this.repository,
  });

  @override
  Future<Either<AuthFailure, void>> call(forgotPassowrdParams) {
    return repository.forgotPassword(forgotPassowrdParams);
  }
}

class ForgotPasswordParams {}
