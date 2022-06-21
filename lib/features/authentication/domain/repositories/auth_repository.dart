import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/login.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';

abstract class AuthRepository extends Repository {
  Future<Either<Failure, User>> login(LoginParameter params);

  Future<Either<Failure, User>> register(RegisterParameter params);

  Future<Either<Failure, User>> googleAuth();

  Future<Either<Failure, User>> facebookAuth();

  Future<Either<Failure, void>> logout();
}
