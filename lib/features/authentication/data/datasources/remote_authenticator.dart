import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/configs/environment_configs.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/user.dart';
import '../../domain/params/params.dart';
import '../models/user_model.dart';
import 'authenticator.dart';

class RemoteAuthenticator implements Authenticator {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  const RemoteAuthenticator({
    required this.dioClient,
    required this.environmentConfig,
  });
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
    try {
      final response = await dioClient.post(
        '${environmentConfig.apihost}/users/login',
        data: {
          'email': loginParameter.email,
          'password': loginParameter.password,
        },
      );
      if (response.statusCode == 200) {
        log(response.data.toString());
        return UserModel.fromMap(response.data);
      }

      throw AuthException(message: "Server Error");
    } on AuthException {
      rethrow;
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? "statuscode: null");
      if ((dioError.response?.statusCode ?? -1) == 400) {
        throw AuthException(
          message: dioError.response?.data?.toString() ?? 'Login Failed',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        throw AuthException(
          message:
              dioError.response?.data?.toString() ?? 'Internal Server Error',
        );
      }
      throw AuthException(
        message: "Error Occurred",
      );
    } catch (e) {
      log(e.toString());
      throw AuthException(message: "An Error Occurred");
    }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> sendOtp(RegisterParameter registerParameter) async {
    try {
      MultipartFile? profilePic;
      if (registerParameter.profilePic != null) {
        profilePic = await MultipartFile.fromFile(
          registerParameter.profilePic!.path,
        );
      }

      final response = await dioClient.post(
        '${environmentConfig.apihost}/users/register',
        data: FormData.fromMap(
          registerParameter.toMap()
            ..addEntries(
              {'profile_pic': profilePic}.entries,
            ),
        ),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return;
      }
      throw AuthException();
    } on AuthException {
      rethrow;
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? "statuscode: null");
      log(dioError.response?.data.toString() ?? 'no data');
      if ((dioError.response?.statusCode ?? -1) == 400) {
        throw AuthException(
          message: dioError.response?.data?.toString() ?? 'Failed to send OTP',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        throw AuthException(
          message:
              dioError.response?.data?.toString() ?? 'Internal Server Error',
        );
      }
      throw AuthException(
        message: "Error Occurred",
      );
    } catch (e) {
      log(e.toString());
      throw AuthException(message: "An Error Occurred");
    }
  }

  @override
  Future<User> register(RegisterParameter registerParameter) async {
    try {
      final body = json.encode(
        {
          'otp': registerParameter.otp,
          'email': registerParameter.email,
        },
      );
      final response = await dioClient.post(
        '${environmentConfig.apihost}/users/verify',
        data: body,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return UserModel.fromMap(response.data);
        } else {
          throw AuthException(message: response.data);
        }
      }
      log(response.data.toString());
      throw AuthException(message: "Server Error");
    } on AuthException {
      rethrow;
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? 'statuscode: -1');
      log(dioError.response?.data ?? "no message");
      if ((dioError.response?.statusCode ?? -1) == 400) {
        throw AuthException(
          message: dioError.response?.data?.toString() ?? 'Failed to send OTP',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        log(dioError.response?.data?.toString() ?? "No error message: 502");
        throw AuthException(
          message: 'Internal Server Error',
        );
      }
      throw AuthException(
        message: "Error Occurred",
      );
    } catch (e) {
      log(e.toString());
      throw AuthException(message: "An Error Occurred");
    }
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
