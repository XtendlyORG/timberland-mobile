import '../../domain/entities/user.dart';
import '../../domain/params/params.dart';

abstract class Authenticator {
  Future<User> login(LoginParameter loginParameter);
  Future<void> requestRegister(RegisterParameter registerParameter);
  Future<User> verifyOtp(String email, String otp);
  Future<void> resendOtp(String email);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();

  Future<void> forgotPassword(String email);
  Future<void> updatePassword(String email, String newPassword);
  Future<void> deleteProfile();
}
