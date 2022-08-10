// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/dashboard/data/datasources/profile_datasource.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/dashboard/domain/repository/profile_repository.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDatasource;
  ProfileRepositoryImpl({
    required this.profileDatasource,
  });
  @override
  Future<Either<Failure, User>> updateUserDetail(
      UpdateUserDetailsParams userDetails) {
    // TODO: implement updateUserDetail
    throw UnimplementedError();
  }
}
