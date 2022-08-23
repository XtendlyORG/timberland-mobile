// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/pages/404_page.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/update_email.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/verify_otp_update_page.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/register.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/registration_continuation_page.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/reset_password.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/checkout_page.dart';

import '../../dashboard/presentation/pages/qr_code_page.dart';
import '../../dashboard/presentation/pages/update_profile_page.dart';
import '../../features/app_infos/presentation/bloc/app_info_bloc.dart';
import '../../features/app_infos/presentation/pages/contacts_page.dart';
import '../../features/app_infos/presentation/pages/faqs_page.dart';
import '../../features/authentication/domain/entities/user.dart';
import '../../features/authentication/presentation/pages/forgot_password.dart';
import '../../features/authentication/presentation/pages/otp_verification_page.dart';
import '../../features/authentication/presentation/pages/pages.dart';
import '../../features/emergency/presentation/pages/emergency_page.dart';
import '../../features/history/presentation/pages/booking_history_page.dart';
import '../../features/history/presentation/pages/payment_history_page.dart';
import '../../features/trail/domain/entities/trail.dart';
import '../../features/trail/presentation/pages/trail_details.dart';
import '../../features/trail/presentation/pages/trail_map.dart';
import '../../main_page.dart';
import '../presentation/widgets/inherited_widgets/inherited_trail.dart';
import '../utils/session.dart';
import 'routes/routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home.path,
  refreshListenable: Session(),
  redirect: (routeState) {
    bool isAuthenticating = [
      Routes.login.path,
      Routes.forgotPassword.path,
      Routes.resetPassword.path,
      Routes.register.path,
      Routes.registerContinuation.path,
      Routes.otpVerification.path,
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
        path: Routes.resetPassword.path,
        name: Routes.resetPassword.name,
        pageBuilder: (context, routeState) {
          return CustomTransitionPage(
            child: const ResetPasswordPage(),
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        }),
    GoRoute(
      path: Routes.register.path,
      name: Routes.register.name,
      pageBuilder: (context, state) {
        log("rebuilt");

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
      path: Routes.registerContinuation.path,
      name: Routes.registerContinuation.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: InheritedRegisterParameter(
            registerParameter: state.extra as RegisterParameter,
            child: const RegistrationContinuationPage(),
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
    ),
    GoRoute(
      path: Routes.otpVerification.path,
      name: Routes.otpVerification.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: OtpVerificationPage(
            routeNameOnPop: state.extra as String,
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
            return CustomTransitionPage(
              child: const MainPage(
                selectedTabIndex: 0,
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
          routes: [
            GoRoute(
              path: Routes.specificTrail.path,
              name: Routes.specificTrail.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: InheritedTrail(
                    trail: (routeState.extra as Trail),
                    child: const TrailDetails(),
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
            return CustomTransitionPage(
              child: const MainPage(
                selectedTabIndex: 1,
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
          path: Routes.profile.asSubPath(),
          name: Routes.profile.name,
          pageBuilder: (context, routeState) {
            return CustomTransitionPage(
              child: const MainPage(
                selectedTabIndex: 3,
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
            GoRoute(
              path: Routes.updateEmail.asSubPath(),
              name: Routes.updateEmail.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const UpdateEmailPage(),
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
              routes: [
                GoRoute(
                  path: Routes.verifyUpdateOtp.asSubPath(),
                  name: Routes.verifyUpdateOtp.name,
                  pageBuilder: (context, routeState) {
                    return CustomTransitionPage(
                      child: const VerifyUpdateOtpPage(),
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
              path: Routes.qr.asSubPath(),
              name: Routes.qr.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const QrCodePage(),
                  // key: routeState.pageKey,
                  // restorationId: routeState.pageKey.value,
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnim, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
            ),
            GoRoute(
              path: Routes.paymentHistory.asSubPath(),
              name: Routes.paymentHistory.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const PaymentHistoryPage(),
                  // key: routeState.pageKey,
                  // restorationId: routeState.pageKey.value,
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnim, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
            ),
            GoRoute(
              path: Routes.bookingHistory.asSubPath(),
              name: Routes.bookingHistory.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const BookingHistoryPage(),
                  // key: routeState.pageKey,
                  // restorationId: routeState.pageKey.value,
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder:
                      (context, animation, secondaryAnim, child) {
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
          path: Routes.booking.asSubPath(),
          name: Routes.booking.name,
          pageBuilder: (context, routeState) {
            return CustomTransitionPage(
              child: const MainPage(
                selectedTabIndex: 2,
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
      ],
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
    GoRoute(
      path: Routes.emergency.path,
      name: Routes.emergency.name,
      pageBuilder: (context, routeState) {
        return CustomTransitionPage(
          key: routeState.pageKey,
          restorationId: routeState.pageKey.value,
          child: const EmergencyPage(),
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
      path: Routes.checkout.path,
      name: Routes.checkout.name,
      pageBuilder: (context, routeState) {
        return CustomTransitionPage(
          // key: routeState.pageKey,
          // restorationId: routeState.pageKey.value,
          child: const CheckoutPage(),
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
      child: RouteNotFoundPage(
        location: state.location,
      ),
    );
  },
);
