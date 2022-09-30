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
      //TODO: implement api request
      
      return EmergencyConfigs(
        appID: '41ac45a81b9a4f298c1341bcafe8bc5c',
        token: '007eJxTYFA9vtki+baIZZQAV73kYRWjV/P+WTn29EW8PcbR8Mj6xUIFBhPDxGQT00QLwyTLRJM0I0uLZENjE8Ok5MS0VIukZNPkOm/T5H9zzJLfBFexMDJAIIjPw1CSWlyim5yRmJeXmsPAAABRsCS9',
        channelID: channelID,
        uid: 0,
      );
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
