import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/configs/environment_configs.dart';
import '../features/history/data/datasources/history_datasource_impl.dart';
import '../features/history/data/repositories/history_repository_impl.dart';
import '../features/history/domain/repositories/history_repository.dart';
import '../features/history/presentation/bloc/history_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<HistoryBloc>(
    () => HistoryBloc(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(
      dataSource: HistoryDataSoureImpl(
        environmentConfig: serviceLocator<EnvironmentConfig>(),
        dioClient: serviceLocator<Dio>(),
      ),
    ),
  );
}
