import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../core/configs/environment_configs.dart';
import '../features/authentication/data/datasources/authenticator.dart';
import '../features/authentication/data/datasources/remote_authenticator.dart';
import '../features/authentication/data/repositories/auth_repository_impl.dart';
import '../features/authentication/domain/repositories/auth_repository.dart';
import '../features/authentication/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(repository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authenticator: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<Authenticator>(
    () => RemoteAuthenticator(
      dioClient: serviceLocator<Dio>(),
      environmentConfig: serviceLocator<EnvironmentConfig>(),
    ),
  );
}
