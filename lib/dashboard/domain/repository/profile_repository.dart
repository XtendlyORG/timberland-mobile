import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../params/update_user_detail.dart';

abstract class ProfileRepository {
  Future<Either<ProfileFailure, User>> updateUserDetail(
      UpdateUserDetailsParams userDetails);

  Future<Either<ProfileFailure, void>> updateEmailRequest(
    String email,
    String password,
  );

  Future<Either<ProfileFailure, void>> resendEmailOtp(String email);

  Future<Either<ProfileFailure, void>> verifyEmailUpdate(
    String email,
    String otp,
  );

  Future<Either<ProfileFailure, void>> updatePasswordRequest(
    String oldPassword,
    String newPassword
  );
}
