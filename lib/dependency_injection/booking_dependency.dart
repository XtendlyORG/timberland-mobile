import 'package:get_it/get_it.dart';

import '../core/configs/base_config.dart';
import '../features/booking/presentation/bloc/booking_bloc.dart';

final serviceLocator = GetIt.instance;
void init(EnvironmentConfig environmentConfig) {
  serviceLocator.registerFactory<BookingBloc>(
    () => BookingBloc(),
  );
}
