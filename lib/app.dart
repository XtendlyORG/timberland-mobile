import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/core/utils/internet_connection.dart';

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
  di.initializeDependencies();
  WidgetsFlutterBinding.ensureInitialized();

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
    _messengerKey = GlobalKey<ScaffoldMessengerState>();

    if (!internetConnectivity.internetConnected) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _messengerKey.currentState!.showSnackBar(
          SnackBar(
            duration: const Duration(days: 1),
            dismissDirection: DismissDirection.none,
            content: const AutoSizeText(
              'No internet connection',
              textAlign: TextAlign.center,
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            margin: const EdgeInsets.only(
              right: 20,
              left: 20,
              bottom: kHorizontalPadding,
            ),
          ),
        );
      });
    }

    internetConnectivity.addListener(() async {
      log("adasd");
      log(internetConnectivity.internetConnected.toString());
      if (!internetConnectivity.internetConnected) {
        log("No internet");
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _messengerKey.currentState!.showSnackBar(
            SnackBar(
              duration: const Duration(days: 1),
              dismissDirection: DismissDirection.none,
              content: const AutoSizeText(
                'No internet connection',
                textAlign: TextAlign.center,
              ),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              margin: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: kHorizontalPadding,
              ),
            ),
          );
        });
      } else {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _messengerKey.currentState?.clearMaterialBanners();
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
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
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
