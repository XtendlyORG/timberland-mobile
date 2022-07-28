import 'app.dart' as app;

Future<void> main() async {
  await app.run(dotEnvFileName: ".env.prod");
}
