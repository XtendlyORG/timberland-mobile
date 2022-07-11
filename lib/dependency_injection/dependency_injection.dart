import 'package:get_it/get_it.dart';

import 'auth_dependency.dart' as auth;
import 'app_info_depencency.dart' as app_info;

final serviceLocator = GetIt.instance;

void init() {
  auth.init();
  app_info.init();
}
