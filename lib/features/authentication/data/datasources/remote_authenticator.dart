import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';

import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import 'authenticator.dart';

final UserModel fakeUser = UserModel(
  id: 'user-id',
  firstName: 'John',
  lastName: 'Smith',
  gender: 'Male',
  birthday: DateTime(2002, 5, 8),
  address: '123 Fake Address',
  profession: 'Fake Profession',
  email: 'johnSmith@email.com',
  mobileNumber: '9123456789',
  age: 20,
  accessCode: 'access-code',
);

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
    return fakeUser;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> register(RegisterParameter registerParameter) async {
    // TODO: implement register
    return fakeUser.copyWith(
      firstName: registerParameter.firstName,
      middleName: registerParameter.middleName,
      lastName: registerParameter.lastName,
      gender: registerParameter.gender,
      birthday: registerParameter.birthDay,
      email: registerParameter.email,
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
