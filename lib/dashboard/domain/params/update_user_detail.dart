// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';

class UpdateUserDetailsParams {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? gender;
  final DateTime? birthday;
  final String? address;
  final String? profession;
  final String? bloodType;
  final String mobileNumber;
  final String? emergencyContactInfo;
  final File? profilePic;
  final String? bikeYear;
  final String? bikeModel;
  final String? bikeColor;

  const UpdateUserDetailsParams({
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.gender,
    this.birthday,
    this.address,
    this.profession,
    this.bloodType,
    required this.mobileNumber,
    this.emergencyContactInfo,
    this.profilePic,
    this.bikeModel,
    this.bikeYear,
    this.bikeColor,
  });

  factory UpdateUserDetailsParams.fromRegisterParams(
    RegisterParameter registerParameter,
  ) =>
      UpdateUserDetailsParams(
        firstName: registerParameter.firstName,
        middleName: registerParameter.middleName,
        lastName: registerParameter.lastName,
        mobileNumber: registerParameter.mobileNumber,
        address: registerParameter.address,
        bikeColor: registerParameter.bikeColor,
        bikeModel: registerParameter.bikeModel,
        bikeYear: registerParameter.bikeYear,
        birthday: registerParameter.birthDay,
        bloodType: registerParameter.bloodType,
        emergencyContactInfo: registerParameter.emergencyContactInfo,
        gender: registerParameter.gender,
        profession: registerParameter.profession,
        profilePic: registerParameter.profilePic,
      );

  UpdateUserDetailsParams copyWith({
    String? otp,
    String? firstName,
    String? middleName,
    String? lastName,
    String? gender,
    DateTime? birthday,
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
    return UpdateUserDetailsParams(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      profession: profession ?? this.profession,
      bloodType: bloodType ?? this.bloodType,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emergencyContactInfo: emergencyContactInfo ?? this.emergencyContactInfo,
      profilePic: profilePic ?? this.profilePic,
      bikeModel: bikeModel ?? this.bikeModel,
      bikeYear: bikeYear ?? this.bikeYear,
      bikeColor: bikeColor ?? this.bikeColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'gender': gender,
      'birthday': birthday?.millisecondsSinceEpoch,
      'address': address,
      'profession': profession,
      'bloodType': bloodType,
      'mobileNumber': mobileNumber,
      'emergencyContactInfo': emergencyContactInfo,
      'bikeYear': bikeYear,
      'bikeModel': bikeModel,
      'bikeColor': bikeColor,
    };
  }
}
