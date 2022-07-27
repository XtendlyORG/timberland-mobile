import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.gender,
    required super.birthday,
    required super.address,
    required super.profession,
    required super.email,
    required super.mobileNumber,
    required super.age,
    required super.accessCode,
  });
}
