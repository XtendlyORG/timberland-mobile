// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/emergency/data/datasources/emergency_datasource.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';

class EmergencyDataSourceImpl implements EmergencyDataSource {
  final Dio dioClient;
  final EnvironmentConfig environmentConfig;

  EmergencyDataSourceImpl({
    required this.dioClient,
    required this.environmentConfig,
  });
  @override
  Future<EmergencyConfigs> fetchToken(String channelID) {
    return this(callback: () async {
      final response = await dioClient.post(
        '${environmentConfig.apihost}/emergencies/rtctoken',
        data: {
          'channel': channelID,
          'isPublisher': true,
        },
      );

      if (response.statusCode == 200) {
        return EmergencyConfigs(
          token: response.data['token'],
          channelID: channelID,
          uid: response.data['uid'],
        );
      }

      throw const EmergencyException(message: 'Failed to request a token');
    });
  }

  Future<ReturnType> call<ReturnType>({
    required Future<ReturnType> Function() callback,
  }) async {
    try {
      return await callback();
    } on DioError catch (dioError) {
      log(dioError.response?.statusCode?.toString() ?? 'statuscode: -1');
      log(dioError.response?.data.toString() ?? "no message");

      throw EmergencyException(message: dioError.message);
    } on EmergencyException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const EmergencyException(message: "An Error Occurred");
    }
  }
}
