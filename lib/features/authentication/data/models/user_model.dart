import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.age,
  });
}
