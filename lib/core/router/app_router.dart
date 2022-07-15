import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/bloc/app_info_bloc.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/pages/faqs_page.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/forgot_password.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/booking_page.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/presentation/pages/trail_details.dart';

import '../../dashboard/presentation/pages/qr_code_page.dart';
import '../../features/authentication/presentation/pages/otp_verification_page.dart';
import '../../features/authentication/presentation/pages/pages.dart';
import '../../main_page.dart';
import '../presentation/widgets/timberland_scaffold.dart';
import '../utils/session.dart';
import 'routes/routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.login.path,
  refreshListenable: Session(),
  redirect: (routeState) {
    bool isAuthenticating = [
      Routes.login.path,
      Routes.forgotPassword.path,
      Routes.register.path,
      Routes.otpVerification.path,
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
      path: Routes.forgotPassword.path,
      name: Routes.forgotPassword.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const ForgotPasswordPage(),
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
      path: Routes.register.path,
      name: Routes.register.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
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
      path: Routes.otpVerification.path,
      name: Routes.otpVerification.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const OtpVerificationPage(),
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
              path: Routes.specificTrail.path,
              name: Routes.specificTrail.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: TrailDetails(
                    trail: (routeState.extra as Trail),
                  ),
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: Routes.rules.asSubPath(),
          name: Routes.rules.name,
          pageBuilder: (context, routeState) {
            final appinfoBloc = BlocProvider.of<AppInfoBloc>(context);
            if (appinfoBloc.state is! TrailRulesState) {
              appinfoBloc.add(
                const FetchTrailRulesEvent(),
              );
            }
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
    GoRoute(
      path: Routes.faqs.path,
      name: Routes.faqs.name,
      pageBuilder: (context, routeState) {
        final appinfoBloc = BlocProvider.of<AppInfoBloc>(context);
        if (appinfoBloc.state is! FAQState) {
          appinfoBloc.add(
            const FetchFAQSEvent(),
          );
        }
        return CustomTransitionPage(
          child: const FAQsPage(),
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
    GoRoute(
      path: Routes.booking.path,
      name: Routes.booking.name,
      pageBuilder: (context, routeState) {
        return CustomTransitionPage(
          child: const BookingPage(),
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
