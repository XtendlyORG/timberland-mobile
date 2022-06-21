import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/login.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';

abstract class Authenticator {
  Future<User> login(LoginParameter loginParameter);
  Future<User> register(RegisterParameter registerParameter);
  Future<User> googleAuth();
  Future<User> facebookAuth();
  Future<void> logout();
}
