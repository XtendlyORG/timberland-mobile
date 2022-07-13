// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:timberland_biketrail/core/configs/base_config.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/app_infos/data/models/trail_rule_model.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

class TimberlandRemoteDatasource implements RemoteDatasource {
  final EnvironmentConfig environmentConfig;
  TimberlandRemoteDatasource({
    required this.environmentConfig,
  });
  final Dio _dio = Dio();

  @override
  Future<List<TrailRule>> fetchTrailRules() async {
    try {
      final response = await _dio.get('${environmentConfig.apihost}/rules',
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
      throw const AppInfoException(message: "Server Error");
    } on AppInfoException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      throw AppInfoException(message: e.toString());
    }
  }
}
