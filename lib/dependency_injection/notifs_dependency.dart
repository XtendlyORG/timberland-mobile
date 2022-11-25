import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/notifications/data/datasources/push_notif_remote_ds.dart';
import 'package:timberland_biketrail/features/notifications/data/repositories/push_notif_repository_impl.dart';
import 'package:timberland_biketrail/features/notifications/domain/repositories/push_notif_repository.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';

import '../core/configs/environment_configs.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerLazySingleton<NotificationsBloc>(
    () => NotificationsBloc(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<PushNotificationRepository>(
    () => PushNotificationRepositoryImpl(
      remoteDataSource: PushNotificationRemoteDataSourceImpl(
        environmentConfig: serviceLocator<EnvironmentConfig>(),
        dioClient: serviceLocator<Dio>(),
      ),
    ),
  );
}
