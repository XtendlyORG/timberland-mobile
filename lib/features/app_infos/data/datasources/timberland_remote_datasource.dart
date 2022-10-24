// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/app_infos/data/models/faq_model.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/inquiry.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

class TimberlandRemoteDatasource implements AppInfoDataSource {
  final EnvironmentConfig environmentConfig;
  final Dio dioClient;
  TimberlandRemoteDatasource({
    required this.environmentConfig,
    required this.dioClient,
  });

  @override
  Future<List<TrailRule>> fetchTrailRules() async {
    try {
      final response = await dioClient.get('${environmentConfig.apihost}/rules',
          options: Options(
            validateStatus: (status) => true,
          ));
      if (response.statusCode == 200) {
        return response.data != null
            ? response.data!
                .map<TrailRule>(
                  (data) => TrailRule(note: data.toString()),
                )
                .toList()
            : [];
      }
      throw const AppInfoException(message: "Server Error");
    } on AppInfoException {
      rethrow;
    } catch (e) {
      throw const AppInfoException(message: "An Error Occurred");
    }
  }

  @override
  Future<List<FAQ>> fetchFAQs() async {
    try {
      final response = await dioClient.get('${environmentConfig.apihost}/faqs',
          options: Options(
            validateStatus: (status) => true,
          ));
      if (response.statusCode == 200) {
        return response.data != null
            ? response.data!
                .map<FAQModel>(
                  (data) => FAQModel.fromMap(data),
                )
                .toList()
            : [];
      }
      throw const AppInfoException(message: "Server Error");
    } on AppInfoException {
      rethrow;
    } catch (e) {
      throw const AppInfoException(message: "An Error Occurred");
    }
  }

  @override
  Future<void> sendInquiry(Inquiry inquiry) {
    return this(callback: () async {
      List<String> imageFieldNames = [
        'first_image',
        'second_image',
        'third_image'
      ];
      List<MultipartFile?> images = [];
      for (var element in inquiry.images) {
        images.add(await MultipartFile.fromFile(element.path));
      }

      final response = await dioClient.post(
        '${environmentConfig.apihost}/members/contacts',
        data: FormData.fromMap(
          inquiry.toMap()
            ..addEntries(
              Map.fromIterables(
                imageFieldNames.getRange(0, images.length),
                images,
              ).entries,
            ),
        ),
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        return;
      }
      throw const AppInfoException(message: "Server Error");
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

      if ((dioError.response?.statusCode ?? -1) == 400) {
        throw AppInfoException(
          message:
              dioError.response?.data.toString() ?? 'Something went wrong..',
        );
      } else if ((dioError.response?.statusCode ?? -1) == 502) {
        log(dioError.response?.data?.toString() ?? "No error message: 502");
        throw const AppInfoException(
          message: 'Internal Server Error',
        );
      }
      throw const AppInfoException(
        message: "Error Occurred",
      );
    } on AppInfoException {
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const AppInfoException(message: "An Error Occurred");
    }
  }
}
