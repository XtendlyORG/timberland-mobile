import 'package:get_it/get_it.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<AppInfoBloc>(
    () => AppInfoBloc(),
  );
}
