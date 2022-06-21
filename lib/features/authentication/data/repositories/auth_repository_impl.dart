// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/authentication/data/datasources/authenticator.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/login.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Authenticator authenticator;
  AuthRepositoryImpl({
    required this.authenticator,
  });

  @override
  Future<Either<Failure, User>> login(LoginParameter params) {
    return authRequest<User>(
      request: () => authenticator.login(params),
    );
  }

  @override
  Future<Either<Failure, User>> register(RegisterParameter params) {
    return authRequest<User>(
      request: () => authenticator.register(params),
    );
  }

  @override
  Future<Either<Failure, User>> facebookAuth() {
    return authRequest(request: authenticator.facebookAuth);
  }

  @override
  Future<Either<Failure, User>> googleAuth() {
    return authRequest(request: authenticator.googleAuth);
  }

  @override
  Future<Either<Failure, void>> logout() {
    return authRequest<void>(
      request: authenticator.logout,
    );
  }

  Future<Either<Failure, ReturnType>> authRequest<ReturnType>({
    required Future<ReturnType> Function() request,
  }) async {
    try {
      return Right(await request());
    } on AuthException catch (exception) {
      return Left(
        AuthFailure(
          message: exception.message ?? 'Server Failure.',
        ),
      );
    }
  }
}
