import 'package:get_it/get_it.dart';

import '../features/booking/presentation/bloc/booking_bloc.dart';
import '../features/trail/domain/repositories/trail_repository.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<BookingBloc>(
    () => BookingBloc(
      trailRepository: serviceLocator<TrailRepository>(),
    ),
  );
}
