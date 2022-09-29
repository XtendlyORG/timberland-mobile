// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String profilePicUrl;
  final String? gender;
  final DateTime? birthday;
  final String? address;
  final String? profession;
  final String? bloodType;
  final String email;
  final String mobileNumber;
  final String? emergencyContactInfo;
  final String? bikeModel;
  final String? bikeYear;
  final String? bikeColor;
  final String accessCode;
  const User({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.profilePicUrl,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.profession,
    this.bloodType,
    required this.email,
    required this.mobileNumber,
    this.emergencyContactInfo,
    this.bikeModel,
    this.bikeYear,
    this.bikeColor,
    required this.accessCode,
  });

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      if (middleName != null) middleName!,
      lastName,
      profilePicUrl,
      if (gender != null) gender!,
      if (birthday != null) birthday!,
      if (address != null) address!,
      if (profession != null) profession!,
      if (bloodType != null) bloodType!,
      email,
      mobileNumber,
      if (bikeModel != null) bikeModel!,
      if (bikeYear != null) bikeYear!,
      if (bikeColor != null) bikeColor!,
      accessCode,
    ];
  }

  User copyWith({
    String? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? profilePicUrl,
    String? gender,
    DateTime? birthday,
    String? address,
    String? profession,
    String? bloodType,
    String? email,
    String? mobileNumber,
    String? emergencyContactInfo,
    String? bikeModel,
    String? bikeYear,
    String? bikeColor,
    String? accessCode,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      profession: profession ?? this.profession,
      bloodType: bloodType ?? this.bloodType,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      emergencyContactInfo: emergencyContactInfo ?? this.emergencyContactInfo,
      bikeModel: bikeModel ?? this.bikeModel,
      bikeYear: bikeYear ?? this.bikeYear,
      bikeColor: bikeColor ?? this.bikeColor,
      accessCode: accessCode ?? this.accessCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'member_id': int.parse(id),
      'firstname': firstName,
      'middlename': middleName,
      'lastname': lastName,
      'profile_pic': profilePicUrl,
      'gender': gender,
      'birth_date':
          birthday != null ? DateFormat('yyyMMdd').format(birthday!) : null,
      'address': address,
      'profession': profession,
      'blood_type': bloodType,
      'email': email,
      'mobile_number': mobileNumber,
      'emergency_number': emergencyContactInfo,
      'bike_model': bikeModel,
      'bike_year': int.tryParse(bikeYear ?? ''),
      'bike_color': bikeColor,
      'access_code': accessCode,
    };
  }

  String toJson() => json.encode(toMap());
}
