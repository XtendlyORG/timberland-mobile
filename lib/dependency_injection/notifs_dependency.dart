import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/announcement_remote_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/repositories/announcement_repository_impl.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/announcement_repository.dart';
import 'package:timberland_biketrail/features/notifications/data/datasources/push_notif_remote_ds.dart';
import 'package:timberland_biketrail/features/notifications/data/repositories/push_notif_repository_impl.dart';
import 'package:timberland_biketrail/features/notifications/domain/repositories/push_notif_repository.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';

import '../core/configs/environment_configs.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerLazySingleton<NotificationsBloc>(
    () => NotificationsBloc(
      repository: serviceLocator(),
      announcementRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<PushNotificationRepository>(
    () => PushNotificationRepositoryImpl(
      remoteDataSource: PushNotificationRemoteDataSourceImpl(
        environmentConfig: serviceLocator<EnvironmentConfig>(),
        dioClient: serviceLocator<Dio>(),
      ),
    ),
  );
  serviceLocator.registerLazySingleton<AnnouncementRepository>(
    () => AnnouncementRepositoryImpl(
      announcementDatasource: AnnouncementRemoteDataSource(
        environmentConfig: serviceLocator<EnvironmentConfig>(),
        dioClient: serviceLocator<Dio>(),
      ),
    ),
  );
}
