import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart'
    as di;

import 'app.dart';
import 'core/configs/dev_config.dart';

Future main() async {
  di.init(DevEnvironmentConfig());
  await dotenv.load(fileName: ".env");
  await run();
}
