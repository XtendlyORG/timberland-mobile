import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/repository.dart';
import '../entities/user.dart';
import '../params/params.dart';

abstract class AuthRepository extends Repository {
  Future<Either<AuthFailure, User>> login(LoginParameter params);

  Future<Either<AuthFailure, User>> fingerPrintAuth();

  Future<Either<AuthFailure, void>> sendOtp(RegisterParameter params);

  Future<Either<AuthFailure, User>> register(RegisterParameter params);

  Future<Either<AuthFailure, User>> googleAuth();

  Future<Either<AuthFailure, User>> facebookAuth();

  Future<Either<AuthFailure, void>> logout();

  Future<Either<AuthFailure, void>> resetPassword(
    ResetPasswordParams restPasswordParams,
  );

  Future<Either<AuthFailure, void>> forgotPassword(
    ForgotPasswordParams forgotPasswordParams,
  );
}
