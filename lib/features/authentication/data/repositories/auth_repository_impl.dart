// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/authentication/data/datasources/authenticator.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/update_profile.dart';
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
  Future<Either<AuthFailure, void>> sendOtp(RegisterParameter params) {
    return authRequest(request: () => authenticator.sendOtp(params));
  }

  @override
  Future<Either<AuthFailure, User>> register(RegisterParameter params) {
    return authRequest<User>(
      request: () => authenticator.register(params),
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
  Future<Either<AuthFailure, void>> forgotPassword(
    ForgotPasswordParams forgotPasswordParams,
  ) {
    return authRequest<void>(
      request: () => authenticator.forgotPassword(forgotPasswordParams),
    );
  }

  @override
  Future<Either<AuthFailure, void>> resetPassword(
    ResetPasswordParams resetPasswordParams,
  ) {
    return authRequest(
      request: () => authenticator.resetPassword(resetPasswordParams),
    );
  }

  @override
  Future<Either<AuthFailure, User>> updateProfile(
      UpdateProfileParams updateProfileParams) {
    return authRequest(
      request: () => authenticator.updateProfile(
        updateProfileParams,
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
