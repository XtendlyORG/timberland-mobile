import 'package:dartz/dartz.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

abstract class ProfileRepository{
  Future<Either<ProfileFailure,User>> updateUserDetail(UpdateUserDetailsParams userDetails);
}