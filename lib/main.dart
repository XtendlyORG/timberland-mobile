import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timberland_biketrail/dashboard/presentation/bloc/profile_bloc.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart'
    as di;
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';

import 'core/configs/dev_config.dart';
import 'core/router/app_router.dart';
import 'core/themes/timberland_theme.dart';
import 'core/utils/session.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  di.init(DevEnvironmentConfig());
  await Session().init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>(
        create: (context) => di.serviceLocator<AuthBloc>(),
      ),
      BlocProvider<AppInfoBloc>(
        create: (context) => di.serviceLocator<AppInfoBloc>(),
      ),
      BlocProvider<TrailBloc>(
        create: (context) => di.serviceLocator<TrailBloc>(),
      ),
      BlocProvider<BookingBloc>(
        create: (context) => di.serviceLocator<BookingBloc>(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => di.serviceLocator<ProfileBloc>(),
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
    FlutterNativeSplash.remove();

    BlocProvider.of<AuthBloc>(context).stream.listen((state) {
      if (state is AuthError) {
        log(state.toString());
      } else if (state is Authenticated) {
        session.login(state.user.id);
      } else if (state is UnAuthenticated) {
        if (!state.keepCurrentUser) {
          session.logout();
        }
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
