import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timberland_biketrail/core/configs/base_config.dart';

class DevEnvironmentConfig implements EnvironmentConfig {
  @override
  String get apihost {
    if (dotenv.env['API_DEV'] == null) {
      throw Exception('NO ENVIRONMENT VARIABLE FOUND');
    }
    return dotenv.env['API_DEV']!;
  }
}
