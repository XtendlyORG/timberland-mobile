// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/pages/404_page.dart';
import 'package:timberland_biketrail/core/presentation/pages/first_time_user_page.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/update_email.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/update_password.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/verify_otp_update_page.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/register.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/registration_continuation_page.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/reset_password.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/cancelled_booking.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/checkout_page.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/failed_booking.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/success_booking.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/waiver.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';
import 'package:timberland_biketrail/features/history/presentation/bloc/history_bloc.dart';
import 'package:timberland_biketrail/features/history/presentation/pages/booking_history_details.dart';

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
import 'routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.home.path,
  refreshListenable: Session(),
  redirect: (routeState) {
    bool isAuthenticating = [
      Routes.login.path,
      Routes.login.path + Routes.loginVerify.path,
      Routes.forgotPassword.path,
      Routes.forgotPassword.path + Routes.forgotPasswordVerify.path,
      Routes.forgotPassword.path + Routes.resetPassword.path,
      Routes.resetPassword.path,
      Routes.register.path,
      Routes.register.path + Routes.registerContinuation.path,
      // Routes.otpVerification.path,
      Routes.register.path + Routes.registerVerify.path,
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
      path: Routes.onboarding.path,
      name: Routes.onboarding.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: const OnboardingSlider(),
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
      path: Routes.login.path,
      name: Routes.login.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          // restorationId: state.pageKey.value,
          key: state.pageKey,
          child: const LoginPage(),
        );
      },
      routes: [
        GoRoute(
          path: Routes.loginVerify.asSubPath(),
          name: Routes.loginVerify.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              restorationId: state.pageKey.value,
              child: OtpVerificationPage<RegisterParameter>(
                // routeNameOnPop: state.extra as String,
                onSubmit: (otp, parameter) {
                  BlocProvider.of<AuthBloc>(context).add(
                    VerifyRegisterEvent(
                      parameter: RegisterParameter(
                        firstName: '',
                        lastName: '',
                        email: parameter.email,
                        mobileNumber: '',
                        password: '',
                      ),
                      otp: otp,
                    ),
                  );
                },
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
      path: Routes.forgotPassword.path,
      name: Routes.forgotPassword.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
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
      routes: [
        GoRoute(
          path: Routes.forgotPasswordVerify.asSubPath(),
          name: Routes.forgotPasswordVerify.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: OtpVerificationPage<String>(
                onSubmit: (otp, parameter) {
                  BlocProvider.of<AuthBloc>(context).add(
                    VerifyForgotPasswordEvent(
                      parameter: parameter,
                      otp: otp,
                    ),
                  );
                },
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
          path: Routes.resetPassword.asSubPath(),
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
          },
        ),
      ],
    ),
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
      routes: [
        GoRoute(
          path: Routes.registerContinuation.asSubPath(),
          name: Routes.registerContinuation.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: InheritedRegisterParameter(
                registerParameter: state.extra as RegisterParameter,
                child: const RegistrationContinuationPage(),
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
          path: Routes.registerVerify.asSubPath(),
          name: Routes.registerVerify.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: OtpVerificationPage<RegisterParameter>(
                // routeNameOnPop: state.extra as String,
                onSubmit: (otp, parameter) {
                  BlocProvider.of<AuthBloc>(context).add(
                    VerifyRegisterEvent(
                      parameter: parameter,
                      otp: otp,
                    ),
                  );
                },
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
              path: Routes.trailMap.path,
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
          ],
        ),
        GoRoute(
          path: Routes.rules.asSubPath(),
          name: Routes.rules.name,
          pageBuilder: (context, routeState) {
            // final appinfoBloc = BlocProvider.of<AppInfoBloc>(context);
            // if (appinfoBloc.state is! TrailRulesState) {
            //   appinfoBloc.add(
            //     const FetchTrailRulesEvent(),
            //   );
            // }
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
              path: Routes.updatePassword.asSubPath(),
              name: Routes.updatePassword.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const UpdatePasswordPage(),
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
                final appinfoBloc = BlocProvider.of<HistoryBloc>(context);
                if (appinfoBloc.state is! PaymentState) {
                  appinfoBloc.add(
                    const FetchPaymentHistory(),
                  );
                }
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
                  final appinfoBloc = BlocProvider.of<HistoryBloc>(context);
                  if (appinfoBloc.state is! BookingState) {
                    appinfoBloc.add(
                      const FetchBookingHistory(),
                    );
                  }
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
                routes: [
                  GoRoute(
                    path: Routes.bookingHistoryDetails.asSubPath(),
                    name: Routes.bookingHistoryDetails.name,
                    pageBuilder: (context, routeState) {
                      return CustomTransitionPage(
                        child: BookingHistoryDetails(
                          bookingHistory: routeState.extra as BookingHistory,
                        ),
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
                ]),
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
          routes: [
            GoRoute(
              path: Routes.bookingWaiver.asSubPath(),
              name: Routes.bookingWaiver.name,
              pageBuilder: (context, routeState) {
                final BookingRequestParams name =
                    routeState.extra as BookingRequestParams;
                return CustomTransitionPage(
                  child: BookingWaiver(
                    bookingRequestParams: name,
                  ),
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
              path: Routes.checkout.asSubPath(),
              name: Routes.checkout.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const CheckoutPage(),
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
              path: Routes.successfulBooking.asSubPath(),
              name: Routes.successfulBooking.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const SuccessBookingPage(),
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
              path: Routes.failedfulBooking.asSubPath(),
              name: Routes.failedfulBooking.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const FailedBookingPage(),
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
              path: Routes.cancelledfulBooking.asSubPath(),
              name: Routes.cancelledfulBooking.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: const CancelledBookingPage(),
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
      ],
    ),
    GoRoute(
      path: Routes.faqs.path,
      name: Routes.faqs.name,
      pageBuilder: (context, routeState) {
        // final appinfoBloc = BlocProvider.of<AppInfoBloc>(context);
        // if (appinfoBloc.state is! FAQState) {
        //   appinfoBloc.add(
        //     const FetchFAQSEvent(),
        //   );
        // }
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
