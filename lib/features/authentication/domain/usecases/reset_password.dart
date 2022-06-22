// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class ResetPassword implements Usecase<void, ResetPasswordParams> {
  @override
  final AuthRepository repository;
  const ResetPassword({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(ResetPasswordParams resetPasswordParams) {
    return repository.resetPassword(resetPasswordParams);
  }
}

class ResetPasswordParams {}
