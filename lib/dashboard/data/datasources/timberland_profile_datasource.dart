// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/data/datasources/profile_datasource.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class TimberlandProfileDataSource implements ProfileDataSource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;
  TimberlandProfileDataSource({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<User> updateUserDetails(
      UpdateUserDetailsParams updateProfileParams) async {
    try {
      MultipartFile? profilePic;
      if (updateProfileParams.profilePic != null) {
        profilePic = await MultipartFile.fromFile(
          updateProfileParams.profilePic!.path,
        );
      }

      final response = await dioClient.put(
        '${environmentConfig.apihost}/users/${Session().currentUser?.id}/details',
        data: FormData.fromMap(
          updateProfileParams.toMap()
            ..addEntries(
              {'profile_pic': profilePic}.entries,
            ),
        ),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        log(response.data.toString());
        return Session().currentUser!.copyWith(
              address: updateProfileParams.address,
              bikeColor: updateProfileParams.bikeColor,
              bikeModel: updateProfileParams.bikeModel,
              bikeYear: updateProfileParams.bikeYear,
              birthday: updateProfileParams.birthday,
              bloodType: updateProfileParams.bloodType,
              emergencyContactInfo: updateProfileParams.emergencyContactInfo,
              firstName: updateProfileParams.firstName,
              gender: updateProfileParams.gender,
              lastName: updateProfileParams.lastName,
              middleName: updateProfileParams.middleName,
              mobileNumber: updateProfileParams.mobileNumber,
              profession: updateProfileParams.profession,
              profilePicUrl: updateProfileParams.profilePic?.path,
            );
      }
      throw const ProfileException();
    } on ProfileException {
      rethrow;
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? "statuscode: null");
      log(dioError.response?.data.toString() ?? 'no data');
      if ((dioError.response?.statusCode ?? -1) == 400) {
        throw ProfileException(
          message: dioError.response?.data?.toString() ?? 'Failed to send OTP',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        log(dioError.response?.data?.toString() ?? "No error message: 502");
        throw const ProfileException(
          message: 'Internal Server Error',
        );
      }
      throw const ProfileException(
        message: "Error Occurred",
      );
    } catch (e) {
      log(e.toString());
      throw const ProfileException(message: "An Error Occurred");
    }
  }
}
