import '../../domain/entities/user.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';
import 'authenticator.dart';

class RemoteAuthenticator implements Authenticator {
  @override
  Future<User> facebookAuth() {
    // TODO: implement facebookAuth
    throw UnimplementedError();
  }

  @override
  Future<User> googleAuth() {
    // TODO: implement googleAuth
    throw UnimplementedError();
  }

  @override
  Future<User> login(LoginParameter loginParameter) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> register(RegisterParameter registerParameter) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(ForgotPasswordParams forgotPasswordParams) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(ResetPasswordParams resetPasswordParams) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<User> fingerPrintAuth() {
    // TODO: implement fingerPrintAuth
    throw UnimplementedError();
  }
}
