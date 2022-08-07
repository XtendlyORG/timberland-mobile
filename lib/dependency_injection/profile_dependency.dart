import 'package:get_it/get_it.dart';

import '../dashboard/presentation/bloc/profile_bloc.dart';

final serviceLocator = GetIt.instance;
void init() {
  serviceLocator.registerFactory<ProfileBloc>(
    () => ProfileBloc(
      repository: serviceLocator(),
    ),
  );
}
