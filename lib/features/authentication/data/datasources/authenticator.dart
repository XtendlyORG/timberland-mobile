import '../../domain/entities/user.dart';
import '../../domain/params/params.dart';
import '../../domain/params/update_profile.dart';

abstract class Authenticator {
  Future<User> login(LoginParameter loginParameter);
  Future<void> sendOtp(RegisterParameter registerParameter);
  Future<User> register(RegisterParameter registerParameter);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();

  Future<void> resetPassword(ResetPasswordParams resetPasswordParams);
  Future<void> forgotPassword(ForgotPasswordParams forgotPasswordParams);

  Future<User> updateProfile(UpdateProfileParams updateProfileParams);
}
