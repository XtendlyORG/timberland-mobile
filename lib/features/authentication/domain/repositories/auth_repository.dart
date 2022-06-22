import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/user.dart';
import '../usecases/forgot_password.dart';
import '../usecases/login.dart';
import '../usecases/register.dart';
import '../usecases/reset_password.dart';

abstract class AuthRepository extends Repository {
  Future<Either<Failure, User>> login(LoginParameter params);

  Future<Either<Failure, User>> register(RegisterParameter params);

  Future<Either<Failure, User>> googleAuth();

  Future<Either<Failure, User>> facebookAuth();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, void>> resetPassword(
    ResetPasswordParams restPasswordParams,
  );

  Future<Either<Failure, void>> forgotPassword(
    ForgotPasswordParams forgotPasswordParams,
  );
}
