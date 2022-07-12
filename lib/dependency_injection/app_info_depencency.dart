import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/remote_datasource.dart';
import 'package:timberland_biketrail/features/app_infos/data/datasources/timberland_remote_datasource.dart';
import 'package:timberland_biketrail/features/app_infos/data/repositories/app_infos_repository_impl.dart';
import 'package:timberland_biketrail/features/app_infos/domain/repositories/app_infos_repository.dart';
import 'package:timberland_biketrail/features/app_infos/domain/usecases/fetch_trail_rules.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';

final serviceLocator = GetIt.instance;
void init(EnvironmentConfig environmentConfig) {
  serviceLocator.registerFactory<AppInfoBloc>(
    () => AppInfoBloc(fetchTrailRules: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<FetchTrailRules>(
    () => FetchTrailRules(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AppInfoRepository>(
    () => AppInfoRepositoryImpl(remoteDatasource: serviceLocator()),
  );
  serviceLocator.registerLazySingleton<RemoteDatasource>(
    () => TimberlandRemoteDatasource(environmentConfig: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => environmentConfig);
}
