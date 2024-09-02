import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/utils/internet_connection.dart';
import 'package:timberland_biketrail/dashboard/presentation/cubit/profile_header_cubit.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';
import 'package:timberland_biketrail/features/booking/presentation/cubit/free_pass_counter_cubit.dart';
import 'package:timberland_biketrail/features/emergency/presentation/bloc/emergency_bloc.dart';
import 'package:timberland_biketrail/features/history/presentation/bloc/history_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/announcement_custom_notif.dart';
import 'package:timberland_biketrail/firebase_options.dart';
import 'package:timberland_biketrail/push_notif_configs.dart';

import 'core/router/app_router.dart';
import 'core/themes/timberland_theme.dart';
import 'core/utils/session.dart';
import 'dashboard/presentation/bloc/profile_bloc.dart';
import 'dependency_injection/dependency_injection.dart' as di;
import 'features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/booking/presentation/bloc/booking_bloc.dart';
import 'features/trail/presentation/bloc/trail_bloc.dart';

Future<void> initMyServiceLocator() async {
  myServiceLocator.registerLazySingleton<GoRouter>(
    () => appRouter,
  );
  return;
}

const platform = MethodChannel('your_channel_name');

Future<void> clearAppData() async {
  try {
    await platform.invokeMethod('clearAppData');
  } on PlatformException catch (e) {
    print("Failed to clear app data: ${e.message}");
  }
}

Future<void> run({
  required String dotEnvFileName,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await clearAppData();
  di.initializeDependencies();

  await dotenv.load(fileName: dotEnvFileName);

  await Firebase.initializeApp(
    name: 'ios',
    options: DefaultFirebaseOptions.ios,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await initFirebaseMessaging();

  await Session().init();
  await InternetConnectivity().init();
  await initMyServiceLocator();
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
      BlocProvider<ProfileHeaderCubit>(
        create: (context) => di.serviceLocator<ProfileHeaderCubit>()..fetchProfileHeaders(),
      ),
      BlocProvider<HistoryBloc>(
        create: (context) => di.serviceLocator<HistoryBloc>(),
      ),
      BlocProvider<FreePassCounterCubit>(
        create: (context) => FreePassCounterCubit(
          repository: di.serviceLocator<BookingRepository>(),
        ),
      ),
      BlocProvider<EmergencyBloc>(
        create: (context) => di.serviceLocator<EmergencyBloc>(),
      ),
      BlocProvider<NotificationsBloc>(
        create: (context) => di.serviceLocator<NotificationsBloc>()..add(FetchLatestAnnouncement()),
      ),
    ],
    child: const MaterialApp(home: MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Timer? notifsTimer;
  void onNotifs() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    final notifId = prefs.getString('firebase-notif-id') ?? '';
    final notifTitle = prefs.getString('firebase-notif-title') ?? '';
    final notifContent = prefs.getString('firebase-notif-content') ?? '';
    log('Main App Firebase notifs $notifTitle $notifContent ${notifTitle != '' && notifContent != ''}');
    if(notifId != '' && notifTitle != '' && notifContent != ''){
      // await prefs.setString('firebase-notif-id', '');
      await prefs.setString('firebase-notif-title', '');
      await prefs.setString('firebase-notif-content', '');
      TMBPModal.notificationToast(
        ctx: context,
        textTitle: notifTitle,
        textContent: notifContent
      );
    }
  }

  @override
  void initState() {
    notifsTimer = Timer.periodic(const Duration(seconds: 5), (Timer t) => onNotifs());
    super.initState();
    final Session session = Session();
    FlutterNativeSplash.remove();

    final InternetConnectivity internetConnectivity = InternetConnectivity();

    if (!internetConnectivity.internetConnected) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        noNetworkToast();
      });
    }
    internetConnectivity.addListener(() async {
      log(internetConnectivity.internetConnected ? "Internet Connected" : "No Internet Connected");
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _networkListener();
      });
    });

    BlocProvider.of<AuthBloc>(context).stream.listen((state) {
      if (state is AuthError) {
        log(state.toString());
      } else if (state is Authenticated) {
        session.login(state.user);
        BlocProvider.of<FreePassCounterCubit>(context).getFreePassCount();
      } else if (state is UnAuthenticated) {
        if (!state.keepCurrentUser) {
          session.logout();
        }
      } else if (state is AccountDeleted) {
        showSuccess('Account deleted successfully');
      }
    });
  }

  _networkListener() {
    if (InternetConnectivity().internetConnected) {
      EasyLoading.dismiss();
    } else {
      noNetworkToast();
    }
  }

  @override
  void dispose() {
    notifsTimer?.cancel();
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
        title: 'Timberland Mountain Bike Park',
        debugShowCheckedModeBanner: false,
        theme: TimberlandTheme.lightTheme,
        routeInformationParser: appRouter.routeInformationParser,
        routeInformationProvider: appRouter.routeInformationProvider,
        routerDelegate: appRouter.routerDelegate,
        builder: EasyLoading.init(),
      ),
    );
  }
}
