import 'package:get_it/get_it.dart';

import '../core/configs/base_config.dart';
import '../features/trail/data/datasources/trail_remote_datasource.dart';
import '../features/trail/data/repositories/trail_repository_impl.dart';
import '../features/trail/domain/repositories/trail_repository.dart';
import '../features/trail/presentation/bloc/trail_bloc.dart';

final serviceLocator = GetIt.instance;
void init(EnvironmentConfig environmentConfig) {
  serviceLocator.registerFactory<TrailBloc>(
    () => TrailBloc(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<TrailRepository>(
    () => TrailRepositoryImpl(
      remoteDatasource: TrailRemoteDatasource(
        environmentConfig: environmentConfig,
        dioClient: serviceLocator(),
      ),
    ),
  );
}
