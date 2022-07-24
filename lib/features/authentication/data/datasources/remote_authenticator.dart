import '../../domain/entities/user.dart';
import '../../domain/usecases/forgot_password.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/reset_password.dart';
import '../models/user_model.dart';
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
  Future<User> login(LoginParameter loginParameter) async {
    // TODO: implement login
    return UserModel(
      id: "test",
      firstName: "FirstName",
      lastName: "LastName",
      email: "Email",
      age: 20,
      accessCode: "Test Access Code",
    );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> register(RegisterParameter registerParameter) async {
    // TODO: implement register
    return UserModel(
      id: "test",
      firstName: registerParameter.firstName,
      lastName: registerParameter.lastName,
      email: registerParameter.email!,
      age: 20,
      accessCode: "Test Access Code",
    );
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
