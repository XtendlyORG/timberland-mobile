import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class RegisterParameter extends Equatable {
  final String? otp;
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
  final Color? bikeColor;
  final String password;
  const RegisterParameter({
    this.otp,
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
    required this.password,
  });

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      mobileNumber,
      password,
    ];
  }

  RegisterParameter copyWith({
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
    Color? bikeColor,
    String? password,
  }) {
    return RegisterParameter(
      otp: otp ?? this.otp,
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
