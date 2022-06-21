// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class FacebookAuth implements Usecase<User, void> {
  @override
  final AuthRepository repository;
  FacebookAuth({
    required this.repository,
  });
  @override
  Future<Either<Failure, User>> call(void params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
