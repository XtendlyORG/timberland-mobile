import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

abstract class ProfileDataSource{
  Future<User> updateUserDetails(UpdateUserDetailsParams userDetailsParams);
}