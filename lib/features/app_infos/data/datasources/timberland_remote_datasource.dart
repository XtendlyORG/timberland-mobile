// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/app_infos/data/models/faq_model.dart';
import 'package:timberland_biketrail/features/app_infos/data/models/trail_rule_model.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

class TimberlandRemoteDatasource implements RemoteDatasource {
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
                .map<TrailRuleModel>(
                  (data) => TrailRuleModel.fromMap(data),
                )
                .toList()
            : [];
      }
      log("status code: ${response.statusCode}");
      throw const AppInfoException(message: "Server Error");
    } on AppInfoException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
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
      log("status code: ${response.statusCode}");
      throw const AppInfoException(message: "Server Error");
    } on AppInfoException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const AppInfoException(message: "An Error Occurred");
    }
  }
}
