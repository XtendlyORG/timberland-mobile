import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

import '../features/booking/presentation/bloc/booking_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<BookingBloc>(
    () => BookingBloc(repository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(
      bookingDatasource: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<BookingDatasource>(
    () => BookingRemoteDataSource(
      dioClient: serviceLocator(),
      environmentConfig: serviceLocator(),
    ),
  );
}
