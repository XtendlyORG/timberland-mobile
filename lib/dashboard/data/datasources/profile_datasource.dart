import '../../../features/authentication/domain/entities/user.dart';
import '../../domain/params/update_user_detail.dart';

abstract class ProfileDataSource{
  Future<User> updateUserDetails(UpdateUserDetailsParams userDetailsParams);
}