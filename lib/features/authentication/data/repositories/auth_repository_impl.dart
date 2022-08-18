// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/authentication/data/datasources/authenticator.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Authenticator authenticator;
  AuthRepositoryImpl({
    required this.authenticator,
  });

  @override
  Future<Either<AuthFailure, User>> login(LoginParameter params) {
    return authRequest<User>(
      request: () => authenticator.login(params),
    );
  }

  @override
  Future<Either<AuthFailure, void>> requestRegister(RegisterParameter params) {
    return authRequest(request: () => authenticator.requestRegister(params));
  }

  @override
  Future<Either<AuthFailure, User>> verifyOtp(String email, String otp) {
    return authRequest<User>(
      request: () => authenticator.verifyOtp(email, otp),
    );
  }

  @override
  Future<Either<AuthFailure, void>> resendOtp(String email) {
    return authRequest<void>(
      request: () => authenticator.resendOtp(email),
    );
  }

  @override
  Future<Either<AuthFailure, User>> facebookAuth() {
    return authRequest(request: authenticator.facebookAuth);
  }

  @override
  Future<Either<AuthFailure, User>> googleAuth() {
    return authRequest(request: authenticator.googleAuth);
  }

  @override
  Future<Either<AuthFailure, void>> logout() {
    return authRequest<void>(
      request: authenticator.logout,
    );
  }

  @override
  Future<Either<AuthFailure, void>> forgotPassword(String email) {
    return authRequest<void>(
      request: () => authenticator.forgotPassword(email),
    );
  }

  @override
  Future<Either<AuthFailure, void>> updatePassword(
    String email,
    String newPassword,
  ) {
    return authRequest(
      request: () => authenticator.updatePassword(
        email,
        newPassword,
      ),
    );
  }

  Future<Either<AuthFailure, ReturnType>> authRequest<ReturnType>({
    required Future<ReturnType> Function() request,
  }) async {
    try {
      return Right(await request());
    } on AuthException catch (exception) {
      if (exception is UnverifiedEmailException) {
        return Left(
          UnverifiedEmailFailure(
            message: exception.message ?? 'Server Failure.',
          ),
        );
      }
      return Left(
        AuthFailure(
          message: exception.message ?? 'Server Failure.',
        ),
      );
    } catch (e) {
      return const Left(
        AuthFailure(
          message: 'Something went wrong.',
        ),
      );
    }
  }
}
