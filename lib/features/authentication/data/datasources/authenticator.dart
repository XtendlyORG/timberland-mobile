import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';

import '../../domain/entities/user.dart';

abstract class Authenticator {
  Future<User> fingerPrintAuth();
  Future<User> login(LoginParameter loginParameter);
  Future<User> register(RegisterParameter registerParameter);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();

  Future<void> resetPassword(ResetPasswordParams resetPasswordParams);
  Future<void> forgotPassword(ForgotPasswordParams forgotPasswordParams);
}
