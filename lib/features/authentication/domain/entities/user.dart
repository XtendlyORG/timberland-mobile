// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
  //TODO: Fields may change
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String gender;
  final DateTime birthday;
  final String address;
  final String profession;
  final String? bloodType;
  final String email;
  final String mobileNumber;
  final String? bikeModel;
  final String? bikeYear;
  final String? bikeColor;
  final int age;
  final String accessCode;
  const User({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.gender,
    required this.birthday,
    required this.address,
    required this.profession,
    this.bloodType,
    required this.email,
    required this.mobileNumber,
    this.bikeModel,
    this.bikeYear,
    this.bikeColor,
    required this.age,
    required this.accessCode,
  });

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      mobileNumber,
      age,
      accessCode,
    ];
  }

 

  User copyWith({
    String? id,
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
    String? bikeModel,
    String? bikeYear,
    String? bikeColor,
    int? age,
    String? accessCode,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      address: address ?? this.address,
      profession: profession ?? this.profession,
      bloodType: bloodType ?? this.bloodType,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bikeModel: bikeModel ?? this.bikeModel,
      bikeYear: bikeYear ?? this.bikeYear,
      bikeColor: bikeColor ?? this.bikeColor,
      age: age ?? this.age,
      accessCode: accessCode ?? this.accessCode,
    );
  }
}
