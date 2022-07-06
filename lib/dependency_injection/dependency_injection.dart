import 'package:get_it/get_it.dart';

import 'auth_dependency.dart' as auth;

final serviceLocator = GetIt.instance;

void init() {
  auth.init();
}
