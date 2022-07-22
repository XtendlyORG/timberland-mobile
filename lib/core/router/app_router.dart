import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/features/trail/presentation/pages/trail_map.dart';

import '../../dashboard/presentation/pages/qr_code_page.dart';
import '../../dashboard/presentation/widgets/update_profile_page.dart';
import '../../features/app_infos/presentation/bloc/app_info_bloc.dart';
import '../../features/app_infos/presentation/pages/contacts_page.dart';
import '../../features/app_infos/presentation/pages/faqs_page.dart';
import '../../features/authentication/domain/entities/user.dart';
import '../../features/authentication/domain/usecases/register.dart';
import '../../features/authentication/presentation/pages/forgot_password.dart';
import '../../features/authentication/presentation/pages/otp_verification_page.dart';
import '../../features/authentication/presentation/pages/pages.dart';
import '../../features/authentication/presentation/widgets/registration_form.dart';
import '../../features/authentication/presentation/widgets/registration_form_continuation.dart';
import '../../features/booking/presentation/pages/booking_page.dart';
import '../../features/trail/domain/entities/trail.dart';
import '../../features/trail/presentation/pages/trail_details.dart';
import '../../main_page.dart';
import '../utils/session.dart';
import 'routes/routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home.path,
  refreshListenable: Session(),
  redirect: (routeState) {
    bool isAuthenticating = [
      Routes.login.path,
      Routes.forgotPassword.path,
      Routes.register.path,
      '${Routes.register.path}${Routes.registerContinuation.path}',
      '${Routes.register.path}${Routes.otpVerification.path}',
    ].contains(routeState.location);
    if (routeState.location == Routes.contacts.path) {
      return null;
    }
    log(routeState.location);
    if (Session().isLoggedIn && isAuthenticating) {
      // if logged in redirect to home page
      return Routes.home.path;
    } else if (!Session().isLoggedIn && !isAuthenticating) {
      //if not logged in redirect to login page
      return Routes.login.path;
    } else if (routeState.location == Routes.contacts.path) {
      return null;
    }
    return null;
  },
  routes: [
    GoRoute(
      path: Routes.login.path,
      name: Routes.login.name,
      pageBuilder: (context, state) {
        return MaterialPage(
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
          child: const RegistrationPage(
            form: RegistrationForm(),
          ),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
      routes: [
        GoRoute(
          path: Routes.registerContinuation.asSubPath(),
          name: Routes.registerContinuation.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: RegistrationPage(
                form: RegistrationContinuationForm(
                  registerParameter: state.extra as RegisterParameter,
                ),
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
        GoRoute(
          path: Routes.otpVerification.asSubPath(),
          name: Routes.otpVerification.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              child: const OtpVerificationPage(),
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
            GoRoute(
              path: Routes.trailMap.asSubPath(),
              name: Routes.trailMap.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const TrailMap(),
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
          routes: [
            GoRoute(
              path: Routes.updateProfile.asSubPath(),
              name: Routes.updateProfile.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: UpdateProfilePage(
                    user: (routeState.extra as User),
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
        final bool? disableBackbutton =
            routeState.extra != null ? routeState.extra as bool : null;
        return CustomTransitionPage(
          child: BookingPage(
            disableBackButton: disableBackbutton,
          ),
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
      path: Routes.contacts.path,
      name: Routes.contacts.name,
      pageBuilder: (context, routeState) {
        return CustomTransitionPage(
          key: routeState.pageKey,
          restorationId: routeState.pageKey.value,
          child: const ContactsPage(),
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
    log(state.location);
    log(state.path.toString());
    return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('404 Page Not Found. ${state.location} as'),
        ),
      ),
    );
  },
);
