import '../../../features/authentication/domain/entities/user.dart';
import '../../domain/params/update_user_detail.dart';

abstract class ProfileDataSource {
  Future<User> updateUserDetails(UpdateUserDetailsParams userDetailsParams);
  Future<void> updateEmailRequest(String email, String password);
  Future<void> resendEmailOtp(String email);
  Future<void> verifyEmailUpdate(String email, String otp);

  Future<void> updatePasswordRequest(String oldPassword, String newPassword);
}
