import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<TrailBloc>(
    () => TrailBloc(),
  );
}
