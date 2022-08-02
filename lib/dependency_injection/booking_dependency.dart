import 'package:get_it/get_it.dart';

import '../features/booking/presentation/bloc/booking_bloc.dart';
final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<BookingBloc>(
    () => BookingBloc(),
  );
}
