// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/repository.dart';

abstract class Usecase<ReturnType, ParameterType> {
  final Repository repository;
  Usecase({
    required this.repository,
  });

  Future<Either<Failure, ReturnType>> call(ParameterType params);
}
