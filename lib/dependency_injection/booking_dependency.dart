import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/blocked_booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/blocked_booking_dates_remote_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/repositories/blocked_booking_dates_repository_impl.dart';
import 'package:timberland_biketrail/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/blocked_booking_dates_repository.dart';
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

  serviceLocator.registerLazySingleton<BlockedBookingRepository>(
    () => BlockedBookingRepositoryImpl(
      bookingDatasource: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<BlockedBookingDatasource>(
    () => BlockedBookingRemoteDataSource(
      dioClient: serviceLocator(),
      environmentConfig: serviceLocator(),
    ),
  );
}
