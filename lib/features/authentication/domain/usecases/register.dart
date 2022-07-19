// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/usecase.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

class Register implements Usecase<User, RegisterParameter> {
  @override
  final AuthRepository repository;

  const Register({required this.repository});

  @override
  Future<Either<AuthFailure, User>> call(params) {
    return repository.register(params);
  }
}

class RegisterParameter extends Equatable {
  final String? otp;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String gender;
  final DateTime birthDay;
  final String address;
  final String profession;
  final String? bloodType;
  final String? email;
  final String? mobileNumber;
  final String? emergencyContactInfo;
  final File? profilePic;
  final String? bikeModel;
  final String? bikeYear;
  final Color? bikeColor;
  final String? password;
  const RegisterParameter({
    this.otp,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender,
    required this.birthDay,
    required this.address,
    required this.profession,
    this.bloodType,
    this.email,
    this.mobileNumber,
    this.emergencyContactInfo,
    this.profilePic,
    this.bikeModel,
    this.bikeYear,
    this.bikeColor,
    this.password,
  });

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      gender,
      birthDay,
      address,
      profession,
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
