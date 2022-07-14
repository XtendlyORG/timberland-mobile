import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';
import 'package:timberland_biketrail/features/trail/data/datasources/trail_remote_datasource.dart';
import 'package:timberland_biketrail/features/trail/data/repositories/trail_repository_impl.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';

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
