import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart'
    as di;
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';

import 'core/router/app_router.dart';
import 'core/themes/timberland_theme.dart';
import 'core/utils/session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Session().init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => di.serviceLocator<AuthBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final Session session = Session();

    BlocProvider.of<AuthBloc>(context).stream.listen((state) {
      if (state is AuthError) {
        log(state.toString());
      } else if (state is Authenticated) {
        session.login(state.user.id);
      } else if (state is UnAuthenticated) {
        session.logout();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Timberland Mountain BikeTrail',
      debugShowCheckedModeBanner: false,
      theme: TimberlandTheme.lightTheme,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      routerDelegate: appRouter.routerDelegate,
    );
  }
}
