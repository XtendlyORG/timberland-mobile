// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';
import 'package:timberland_biketrail/core/errors/exceptions.dart';
import 'package:timberland_biketrail/features/trail/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/trail/data/models/trail_model.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';

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

      log("status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data != null
            ? response.data!
                .map<TrailModel>(
                  (data) => TrailModel.fromMap(data),
                )
                .toList()
            : [];
      }

      throw const TrailException(message: "Server Error");
    } on TrailException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const TrailException(message: "An Error Occurred");
    }
  }

  @override
  Future<List<Trail>> searchTrails(SearchTrailsParams searchParams) async {
    try {
      log(searchParams.toMap().toString());
      final response = await dioClient.get(
        '${environmentConfig.apihost}/trails/search/filters?',
        queryParameters: searchParams.toMap(),
        options: Options(
          validateStatus: (status) => true,
        ),
      );
      log("status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data != null
            ? response.data!
                .map<TrailModel>(
                  (data) => TrailModel.fromMap(data),
                )
                .toList()
            : [];
      }

      throw TrailException(message: "Server Error ${response.statusCode}");
    } on TrailException catch (e) {
      log(e.toString());
      rethrow;
    } catch (e) {
      log(e.toString());
      throw const TrailException(message: "An Error Occurred");
    }
  }
}
