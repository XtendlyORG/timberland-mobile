import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/configs/environment_configs.dart';
import 'app_info_depencency.dart' as app_info;
import 'auth_dependency.dart' as auth;
import 'booking_dependency.dart' as booking;
import 'emergency_dependency.dart' as emergency;
import 'history_dependency.dart' as history;
import 'profile_dependency.dart' as profile;
import 'trail_dependency.dart' as trail;

final serviceLocator = GetIt.instance;

void initializeDependencies() {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator
      .registerLazySingleton<EnvironmentConfig>(() => EnvironmentConfig());
  auth.init();
  app_info.init();
  trail.init();
  booking.init();
  profile.init();
  history.init();
  emergency.init();
}
