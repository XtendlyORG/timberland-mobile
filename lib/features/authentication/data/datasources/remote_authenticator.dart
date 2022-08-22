import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/configs/environment_configs.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/session.dart';
import '../../domain/entities/user.dart';
import '../../domain/params/params.dart';
import '../../../../dashboard/domain/params/update_user_detail.dart';
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
        if ((dioError.response?.data?.toString() ?? '') ==
            'Email not Verified') {
          throw UnverifiedEmailException(
            message: 'Email is not verified',
          );
        }
        if (dioError.response?.data is Map<String, dynamic>) {
          if (dioError.response?.data['message'] ==
              'Invalid credentials. Please try again.') {
            throw AuthException(
              message: 'Email or password is incorrect. Please try again.',
            );
          }
          throw AuthException(
            message: dioError.response?.data?['message'].toString() ?? 'Login Failed',
          );
        }
        throw AuthException(
          message: dioError.response?.data?.toString() ?? 'Login Failed',
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
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> requestRegister(RegisterParameter registerParameter) async {
    try {
      MultipartFile? profilePic;
      if (registerParameter.profilePic != null) {
        profilePic = await MultipartFile.fromFile(
          registerParameter.profilePic!.path,
        );
      }

      final Response response;

      response = await dioClient.post(
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
        if ((dioError.response?.data?.toString() ?? '') ==
            "Email found but not verified, OTP needed") {
          throw AuthException(
            message:
                "Your email is already in our system. Please proceed to login	",
          );
        } else if ((dioError.response?.data?.toString() ?? '') ==
            "Your email is already in our system. Please proceed to login.") {
          throw AuthException(
            message: "Email has already been taken.",
          );
        }
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
  Future<User> verifyOtp(String email, String otp) async {
    try {
      final body = json.encode(
        {
          'otp': otp,
          'email': email,
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
      log(dioError.response?.data.toString() ?? "no message");

      if ((dioError.response?.statusCode ?? -1) == 400) {
        if (dioError.response?.data is Map<String, dynamic>) {
          if (dioError.response?.data['message'] == 'Wrong OTP') {
            throw AuthException(
              message:
                  'Invalid OTP. Please enter the one time pin sent to your email',
            );
          }
          throw AuthException(
            message:
                dioError.response?.data['message'] ?? 'Something went wrong..',
          );
        } else {
          throw AuthException(
            message:
                dioError.response?.data?.toString() ?? 'Failed to send OTP',
          );
        }
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
  Future<void> resendOtp(String email) async {
    try {
      final Response response;

      response = await dioClient.put(
        '${environmentConfig.apihost}/users/otp',
        data: {
          'email': email,
        },
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
          message:
              dioError.response?.data?.toString() ?? 'Failed to resend OTP',
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
  Future<void> forgotPassword(String email) async {
    try {
      final body = json.encode(
        {
          'email': email,
        },
      );
      final Response response;

      response = await dioClient.post(
        '${environmentConfig.apihost}/users/forgot',
        data: body,
      );

      log(response.statusCode.toString());
      log(response.data.toString());
      if (response.statusCode == 200) {
        return;
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
  Future<void> updatePassword(String email, String newPassword) async {
    try {
      final body = json.encode(
        {
          'email': email,
          'new_password': newPassword,
        },
      );
      final response = await dioClient.put(
        '${environmentConfig.apihost}/users/forgot/change',
        data: body,
      );
      log(response.statusCode.toString());
      log(response.data.toString());
      if (response.statusCode == 200) {
        return;
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
}
