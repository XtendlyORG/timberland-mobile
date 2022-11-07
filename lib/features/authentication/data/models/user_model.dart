import 'dart:developer';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.prettierID,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.bloodType,
    required super.profilePicUrl,
    required super.gender,
    required super.birthday,
    required super.address,
    required super.profession,
    required super.email,
    required super.mobileNumber,
    required super.bikeModel,
    required super.bikeYear,
    required super.bikeColor,
    required super.accessCode,
    required super.emergencyContactInfo,
  });
  factory UserModel.fromMap(Map<String, dynamic> map) {
    map.forEach(
      (key, value) {
        log('$key:${value.runtimeType}');
      },
    );
    return UserModel(
      id: (map['member_id'] as num?).toString(),
      prettierID: map['long_id'] as String,
      firstName: map['firstname'] as String,
      middleName:
          map['middlename'] != null ? map['middlename'] as String : null,
      lastName: map['lastname'] as String,
      profilePicUrl: map['profile_pic'] as String? ?? '',
      gender: map['gender'] as String,
      birthday: DateTime.tryParse(map['birth_date'] as String? ?? ''),
      address: map['address'] != null ? map['address'] as String : null,
      profession:
          map['profession'] != null ? map['profession'] as String : null,
      bloodType: map['blood_type'] != null ? map['blood_type'] as String : null,
      email: map['email'] as String,
      mobileNumber: map['mobile_number'] as String,
      bikeModel: map['bike_model'] != null ? map['bike_model'] as String : null,
      bikeYear: map['bike_year'] != null
          ? (map['bike_year'] as num).toString()
          : null,
      bikeColor: map['bike_color'] != null ? map['bike_color'] as String : null,
      accessCode: map['access_code'] as String,
      emergencyContactInfo: map['emergency_number'] != null
          ? map['emergency_number'] as String
          : null,
    );
  }
}
