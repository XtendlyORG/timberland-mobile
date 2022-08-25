import 'package:get_it/get_it.dart';

import '../dashboard/data/datasources/profile_datasource.dart';
import '../dashboard/data/datasources/timberland_profile_datasource.dart';
import '../dashboard/data/repositories/profile_repository_impl.dart';
import '../dashboard/domain/repository/profile_repository.dart';
import '../dashboard/presentation/bloc/profile_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      repository: serviceLocator<ProfileRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      profileDatasource: serviceLocator<ProfileDataSource>(),
    ),
  );
  serviceLocator.registerLazySingleton<ProfileDataSource>(
    () => TimberlandProfileDataSource(
      dioClient: serviceLocator(),
      environmentConfig: serviceLocator(),
    ),
  );
}
