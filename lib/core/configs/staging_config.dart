import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'base_config.dart';

class StagingEnvironmentConfig implements EnvironmentConfig {
  @override
  String get apihost {
    if (dotenv.env['API_URL'] == null) {
      throw Exception('NO ENVIRONMENT VARIABLE FOUND');
    }
    return dotenv.env['API_URL']!;
  }
}
