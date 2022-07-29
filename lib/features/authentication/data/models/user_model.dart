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
    required super.bloodType,
    required super.email,
    required super.mobileNumber,
    required super.bikeModel,
    required super.bikeYear,
    required super.bikeColor,
    required super.age,
    required super.accessCode,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      middleName:
          map['middleName'] != null ? map['middleName'] as String : null,
      lastName: map['lastName'] as String,
      gender: map['gender'] as String,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      address: map['address'] as String,
      profession: map['profession'] as String,
      bloodType: map['bloodType'] != null ? map['bloodType'] as String : null,
      email: map['email'] as String,
      mobileNumber: map['mobileNumber'] as String,
      bikeModel: map['bikeModel'] != null ? map['bikeModel'] as String : null,
      bikeYear: map['bikeYear'] != null ? map['bikeYear'] as String : null,
      bikeColor: map['bikeColor'] != null ? map['bikeColor'] as String : null,
      age: map['age'] as int,
      accessCode: map['accessCode'] as String,
    );
  }
}
