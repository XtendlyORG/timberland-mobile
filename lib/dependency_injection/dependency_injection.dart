import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';

import 'auth_dependency.dart' as auth;
import 'app_info_depencency.dart' as app_info;
import 'trail_dependency.dart' as trail;

final serviceLocator = GetIt.instance;

void init(EnvironmentConfig environmentConfig) {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  auth.init();
  app_info.init(environmentConfig);
  trail.init(environmentConfig);
}
