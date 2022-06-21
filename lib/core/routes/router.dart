import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/routes/routes.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/login_page.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/pages.dart';

final router = GoRouter(
  initialLocation: Routes.home.path,
  //refreshListenable: AuthstateChanges.
  redirect: (routeState) {
    //TODO: Check if auth status and redirect to correct page

    return null;
  },
  routes: [
    GoRoute(
      path: Routes.home.path,
      name: Routes.home.name,
      pageBuilder: (context, state) {
        //TODO: Perform Data fetching (if needed), then Return HomePage
        return MaterialPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const Scaffold(
            body: Center(
              child: Text('Home Page'),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: Routes.login.path,
      name: Routes.login.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const LoginPage(),
        );
      },
    ),
    GoRoute(
      path: Routes.register.path,
      name: Routes.register.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const RegistrationPage(),
        );
      },
    ),
  ],
  errorPageBuilder: (context, state) {
    // TODO: Return Error Page
    return MaterialPage(
      key: state.pageKey,
      child: const Scaffold(
        body: Center(
          child: Text('404 Page Not Found.'),
        ),
      ),
    );
  },
);
