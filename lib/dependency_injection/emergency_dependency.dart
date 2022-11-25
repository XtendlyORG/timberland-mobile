import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/emergency/data/datasources/emergency_datasource_impl.dart';
import 'package:timberland_biketrail/features/emergency/data/repositories/emergency_repository_impl.dart';
import 'package:timberland_biketrail/features/emergency/domain/repositories/emergency_repository.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';

import '../core/configs/environment_configs.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerLazySingleton<EmergencyBloc>(
    () => EmergencyBloc(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<EmergencyRepository>(
    () => EmergencyRepositoryImpl(
      dataSource: EmergencyDataSourceImpl(
        environmentConfig: serviceLocator<EnvironmentConfig>(),
        dioClient: serviceLocator<Dio>(),
      ),
    ),
  );
}
