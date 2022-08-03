// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class UpdateProfileParams {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? gender;
  final DateTime? birthDay;
  final String? address;
  final String? profession;
  final String? bloodType;
  final String email;
  final String mobileNumber;
  final String? emergencyContactInfo;
  final File? profilePic;
  final String? bikeModel;
  final String? bikeYear;
  final String? bikeColor;
  final String? password;
  UpdateProfileParams({
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.gender,
    this.birthDay,
    this.address,
    this.profession,
    this.bloodType,
    required this.email,
    required this.mobileNumber,
    this.emergencyContactInfo,
    this.profilePic,
    this.bikeModel,
    this.bikeYear,
    this.bikeColor,
    this.password,
  });

  UpdateProfileParams copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? gender,
    DateTime? birthDay,
    String? address,
    String? profession,
    String? bloodType,
    String? email,
    String? mobileNumber,
    String? emergencyContactInfo,
    File? profilePic,
    String? bikeModel,
    String? bikeYear,
    String? bikeColor,
    String? password,
  }) {
    return UpdateProfileParams(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      address: address ?? this.address,
      profession: profession ?? this.profession,
      bloodType: bloodType ?? this.bloodType,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emergencyContactInfo: emergencyContactInfo ?? this.emergencyContactInfo,
      profilePic: profilePic ?? this.profilePic,
      bikeModel: bikeModel ?? this.bikeModel,
      bikeYear: bikeYear ?? this.bikeYear,
      bikeColor: bikeColor ?? this.bikeColor,
      password: password ?? this.password,
    );
  }
}
