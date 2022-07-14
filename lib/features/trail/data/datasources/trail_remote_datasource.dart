// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/trail/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/trail/data/models/trail_model.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';

class TrailRemoteDatasource implements RemoteDatasource {
  final EnvironmentConfig environmentConfig;
  final Dio dioClient;
  const TrailRemoteDatasource({
    required this.environmentConfig,
    required this.dioClient,
  });
  @override
  Future<List<Trail>> fetchTrails(FetchTrailsParams fetchTrailsParams) async {
    try {
      final response = await dioClient.get(
        '${environmentConfig.apihost}/trails',
        options: Options(
          validateStatus: (status) => true,
        ),
      );

      if (response.statusCode == 200) {
        return response.data != null
            ? response.data!
                .map<TrailModel>(
                  (data) => TrailModel.fromMap(data),
                )
                .toList()
            : [];
      }
      log("status code: ${response.statusCode}");
      throw const TrailException(message: "Server Error");
    } on AppInfoException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      throw TrailException(message: e.toString());
    }
  }
}
