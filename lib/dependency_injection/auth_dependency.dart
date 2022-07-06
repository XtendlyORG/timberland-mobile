import 'package:get_it/get_it.dart';

import '../features/authentication/data/datasources/authenticator.dart';
import '../features/authentication/data/datasources/remote_authenticator.dart';
import '../features/authentication/data/repositories/auth_repository_impl.dart';
import '../features/authentication/domain/repositories/auth_repository.dart';
import '../features/authentication/domain/usecases/usecases.dart';
import '../features/authentication/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      facebookAuth: serviceLocator(),
      googleAuth: serviceLocator(),
      login: serviceLocator(),
      logout: serviceLocator(),
      register: serviceLocator(),
      resetPassword: serviceLocator(),
      forgotPassword: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => FacebookAuth(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => GoogleAuth(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => Login(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => Logout(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => Register(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ResetPassword(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ForgotPassword(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authenticator: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<Authenticator>(
    () => RemoteAuthenticator(),
  );
}
