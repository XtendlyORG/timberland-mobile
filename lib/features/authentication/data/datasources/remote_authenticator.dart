import 'package:timberland_biketrail/features/authentication/data/datasources/authenticator.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/login.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';

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
}
