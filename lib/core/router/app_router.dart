import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/qr_code_page.dart';

import '../../features/authentication/presentation/pages/pages.dart';
import '../../main_page.dart';
import '../utils/session.dart';
import 'routes/routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.login.path,
  refreshListenable: Session(),
  redirect: (routeState) {
    bool isAuthenticating = [
      Routes.login.path,
      Routes.register.path,
    ].contains(routeState.location);

    if (Session().isLoggedIn && isAuthenticating) {
      // if logged in redirect to home page
      return Routes.home.path;
    } else if (!Session().isLoggedIn && !isAuthenticating) {
      //if not logged in redirect to login page
      return Routes.login.path;
    }
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
        return CustomTransitionPage(
          key: state.pageKey,
          child: const RegistrationPage(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
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
          routeState.location,
        )) {
          log(routeState.location);
          return null;
        }
        return Routes.trails.path;
      },
      routes: [
        GoRoute(
          path: Routes.trails.asSubPath(),
          name: Routes.trails.name,
          pageBuilder: (context, routeState) {
            log('trail list');
            return const MaterialPage(
              child: MainPage(
                selectedTabIndex: 0,
              ),
            );
          },
          routes: [
            GoRoute(
              path: ':id',
              name: Routes.specificTrail.name,
              pageBuilder: (context, routeState) {
                log('specificTrail');
                return MaterialPage(
                  child: Center(child: Text(routeState.params['id']!)),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.rules.asSubPath(),
          name: Routes.rules.name,
          pageBuilder: (context, routeState) {
            log('rules');
            return const MaterialPage(
              child: MainPage(
                selectedTabIndex: 1,
              ),
            );
          },
        ),
        GoRoute(
          path: Routes.profile.asSubPath(),
          name: Routes.profile.name,
          pageBuilder: (context, routeState) {
            log('profile');
            return const MaterialPage(
              child: MainPage(
                selectedTabIndex: 3,
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: Routes.qr.path,
      name: Routes.qr.name,
      pageBuilder: (context, routeState) {
        return CustomTransitionPage(
          child: const QrCodePage(),
          // key: routeState.pageKey,
          // restorationId: routeState.pageKey.value,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnim, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
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
