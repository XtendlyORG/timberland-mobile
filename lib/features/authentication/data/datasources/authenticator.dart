import '../../domain/entities/user.dart';
import '../../domain/params/params.dart';

abstract class Authenticator {
  Future<User> fingerPrintAuth();
  Future<User> login(LoginParameter loginParameter);
  Future<void> sendOtp(RegisterParameter registerParameter);
  Future<User> register(RegisterParameter registerParameter);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();

  Future<void> resetPassword(ResetPasswordParams resetPasswordParams);
  Future<void> forgotPassword(ForgotPasswordParams forgotPasswordParams);
}
