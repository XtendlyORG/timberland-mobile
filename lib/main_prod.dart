import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart'
    as di;

import 'app.dart';
import 'core/configs/prod_config.dart';

Future main() async {
  di.init(ProdEnvironmentConfig());
  await dotenv.load(fileName: ".env.prod");
  await run();
}
