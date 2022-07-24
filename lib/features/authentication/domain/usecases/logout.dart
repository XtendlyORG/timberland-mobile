// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class Logout implements Usecase<void, void> {
  @override
  final AuthRepository repository;
  Logout({
    required this.repository,
  });
  @override
  Future<Either<AuthFailure, void>> call(void _) {
    return repository.logout();
  }
}
