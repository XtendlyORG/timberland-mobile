import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timberland_biketrail/core/presentation/widgets/snackbar_content/no_network_snackbar.dart';
import 'package:timberland_biketrail/core/utils/internet_connection.dart';
import 'package:timberland_biketrail/features/history/presentation/bloc/history_bloc.dart';

import 'core/router/app_router.dart';
import 'core/themes/timberland_theme.dart';
import 'core/utils/session.dart';
import 'dashboard/presentation/bloc/profile_bloc.dart';
import 'dependency_injection/dependency_injection.dart' as di;
import 'features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/booking/presentation/bloc/booking_bloc.dart';
import 'features/trail/presentation/bloc/trail_bloc.dart';

Future<void> run({
  required String dotEnvFileName,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  di.initializeDependencies();
  

  await dotenv.load(fileName: dotEnvFileName);

  await Session().init();
  await InternetConnectivity().init();

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
      BlocProvider<HistoryBloc>(
        create: (context) => di.serviceLocator<HistoryBloc>(),
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
  late final GlobalKey<ScaffoldMessengerState> _messengerKey;
  @override
  void initState() {
    super.initState();
    final Session session = Session();
    FlutterNativeSplash.remove();

    final InternetConnectivity internetConnectivity = InternetConnectivity();
    _messengerKey = internetConnectivity.scaffoldMessengerKey;

    if (!internetConnectivity.internetConnected) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _messengerKey.currentState?.showSnackBar(noNetworkSnackBar);
      });
    }
    internetConnectivity.addListener(() async {
      log(internetConnectivity.internetConnected.toString());
      if (!internetConnectivity.internetConnected) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _messengerKey.currentState?.showSnackBar(noNetworkSnackBar);
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _messengerKey.currentState?.clearSnackBars();
        });
      }
    });

    BlocProvider.of<AuthBloc>(context).stream.listen((state) {
      if (state is AuthError) {
        log(state.toString());
      } else if (state is Authenticated) {
        session.login(state.user);
      } else if (state is UnAuthenticated) {
        if (!state.keepCurrentUser) {
          session.logout();
        }
      }
    });
  }

  @override
  void dispose() {
    InternetConnectivity().removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusManager.instance.primaryFocus;
        if (currentFocus != null && currentFocus.hasFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp.router(
        scaffoldMessengerKey: _messengerKey,
        title: 'Timberland Mountain BikeTrail',
        debugShowCheckedModeBanner: false,
        theme: TimberlandTheme.lightTheme,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        routerDelegate: appRouter.routerDelegate,
      ),
    );
  }
}
