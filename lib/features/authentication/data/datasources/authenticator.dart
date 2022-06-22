import '../../domain/entities/user.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';

abstract class Authenticator {
  Future<User> login(LoginParameter loginParameter);
  Future<User> register(RegisterParameter registerParameter);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();

  Future<void> resetPassword(ResetPasswordParams resetPasswordParams);
  Future<void> forgotPassword(ForgotPasswordParams forgotPasswordParams);
}
