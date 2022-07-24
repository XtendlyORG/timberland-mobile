import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/configs/base_config.dart';
import 'app_info_depencency.dart' as app_info;
import 'auth_dependency.dart' as auth;
import 'trail_dependency.dart' as trail;

final serviceLocator = GetIt.instance;

void init(EnvironmentConfig environmentConfig) {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  auth.init();
  app_info.init(environmentConfig);
  trail.init(environmentConfig);
}
