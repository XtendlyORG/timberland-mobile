import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../features/authentication/domain/entities/user.dart';
import '../params/update_user_detail.dart';

abstract class ProfileRepository{
  Future<Either<ProfileFailure,User>> updateUserDetail(UpdateUserDetailsParams userDetails);
}