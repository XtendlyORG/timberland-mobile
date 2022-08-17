import '../../domain/entities/user.dart';
import '../../domain/params/params.dart';
import '../../../../dashboard/domain/params/update_user_detail.dart';

abstract class Authenticator {
  Future<User> login(LoginParameter loginParameter);
  Future<void> sendOtp(
    RegisterParameter registerParameter, {
    bool resending = false,
  });
  Future<User> register(RegisterParameter registerParameter);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();

  Future<void> forgotPassword(String email, {bool resending = false});
  Future<void> forgotPasswordEmailVerification(String email, String otp);
  Future<void> updatePassword(String email, String newPassword);
}
