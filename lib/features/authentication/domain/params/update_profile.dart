// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';

class UpdateProfileParams extends RegisterParameter {
  const UpdateProfileParams({
    required super.firstName,
    super.middleName,
    required super.lastName,
    super.gender,
    super.birthDay,
    super.address,
    super.profession,
    super.bloodType,
    required super.email,
    required super.mobileNumber,
    super.emergencyContactInfo,
    super.profilePic,
    super.bikeModel,
    super.bikeYear,
    super.bikeColor,
    super.password = '',
  });

  factory UpdateProfileParams.fromRegisterParams(
    RegisterParameter registerParameter,
  ) =>
      UpdateProfileParams(
        firstName: registerParameter.firstName,
        middleName: registerParameter.middleName,
        lastName: registerParameter.lastName,
        email: registerParameter.email,
        mobileNumber: registerParameter.mobileNumber,
        address: registerParameter.address,
        bikeColor: registerParameter.bikeColor,
        bikeModel: registerParameter.bikeModel,
        bikeYear: registerParameter.bikeYear,
        birthDay: registerParameter.birthDay,
        bloodType: registerParameter.bloodType,
        emergencyContactInfo: registerParameter.emergencyContactInfo,
        gender: registerParameter.gender,
        password: registerParameter.password,
        profession: registerParameter.profession,
        profilePic: registerParameter.profilePic,
      );

  @override
  UpdateProfileParams copyWith({
    String? otp,
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
