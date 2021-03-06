import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/configs/environment_configs.dart';
import '../features/app_infos/data/datasources/timberland_remote_datasource.dart';
import '../features/app_infos/data/repositories/app_infos_repository_impl.dart';
import '../features/app_infos/domain/repositories/app_infos_repository.dart';
import '../features/app_infos/presentation/bloc/app_info_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<AppInfoBloc>(
    () => AppInfoBloc(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AppInfoRepository>(
    () => AppInfoRepositoryImpl(
      remoteDatasource: TimberlandRemoteDatasource(
        environmentConfig: serviceLocator<EnvironmentConfig>(),
        dioClient: serviceLocator<Dio>(),
      ),
    ),
  );
}

