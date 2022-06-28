import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/routes/routes.dart';

import 'package:timberland_biketrail/features/authentication/presentation/pages/pages.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home.path,
  redirect: (routeState) {
    //TODO: Check auth status and redirect to the right page

    return null;
  },
  routes: [
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
    GoRoute(
      path: Routes.home.path,
      name: Routes.home.name,
      redirect: (routeState) {
        if ([
          Routes.trails.name,
          Routes.rules.name,
          Routes.emergency.name,
          Routes.profile.name,
        ].contains(
          routeState.params['tab'],
        )) {
          return null;
        }
        return Routes.trails.path;
      },
      routes: [
        GoRoute(
          path: Routes.trails.asSubPath(),
          name: Routes.trails.name,
          pageBuilder: (context, routeState) {
            return const MaterialPage(
              child: Scaffold(
                body: Center(
                  child: Text('Trail List'),
                ),
              ),
            );
          },
          routes: [
            GoRoute(
              path: ':id',
              name: Routes.specificTrail.name,
              pageBuilder: (context, routeState) {
                return const MaterialPage(
                  child: Scaffold(
                    body: Center(
                      child: Text('Specific Trail'),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    )
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
