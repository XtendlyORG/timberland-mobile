// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/constants/helpers.dart';
import 'package:timberland_biketrail/core/presentation/pages/404_page.dart';
import 'package:timberland_biketrail/core/presentation/pages/first_time_user_page.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_register_parameter.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/update_email.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/update_password.dart';
import 'package:timberland_biketrail/dashboard/presentation/pages/verify_otp_update_page.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/contact_us_success.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/register.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/registration_continuation_page.dart';
import 'package:timberland_biketrail/features/authentication/presentation/pages/reset_password.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/cancelled_booking.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/checkout_page.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/failed_booking.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/success_booking.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/waiver.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';
import 'package:timberland_biketrail/features/history/presentation/bloc/history_bloc.dart';
import 'package:timberland_biketrail/features/history/presentation/pages/booking_history_details.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';
import 'package:timberland_biketrail/features/notifications/presentation/pages/announcement_list.dart';
import 'package:timberland_biketrail/features/notifications/presentation/pages/announcement_page.dart';
import 'package:timberland_biketrail/features/notifications/presentation/pages/announcement_view.dart';
import 'package:timberland_biketrail/features/notifications/presentation/pages/checkout_now_page.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/notification_listener.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../dashboard/presentation/pages/qr_code_page.dart';
import '../../dashboard/presentation/pages/update_profile_page.dart';
import '../../features/app_infos/presentation/pages/contacts_page.dart';
import '../../features/app_infos/presentation/pages/faqs_page.dart';
import '../../features/authentication/domain/entities/user.dart';
import '../../features/authentication/presentation/pages/forgot_password.dart';
import '../../features/authentication/presentation/pages/otp_verification_page.dart';
import '../../features/authentication/presentation/pages/pages.dart';
import '../../features/emergency/presentation/pages/emergency_page.dart';
import '../../features/history/presentation/pages/booking_history_page.dart';
import '../../features/history/presentation/pages/payment_history_page.dart';
import '../../features/notifications/presentation/pages/announcement_page2.dart';
import '../../features/trail/domain/entities/trail.dart';
import '../../features/trail/presentation/pages/trail_details.dart';
import '../../features/trail/trail_map_new/custom_map_page.dart';
import '../../main_page.dart';
import '../presentation/widgets/inherited_widgets/inherited_trail.dart';
import '../utils/session.dart';
import 'routes.dart';

final myServiceLocator = GetIt.instance;

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
    if ([
      Routes.contacts.path,
      Routes.contacts.path + Routes.contactSuccess.path,
      Routes.checkoutNotification.path,
      Routes.emergency.path,
      Routes.announcements.path,
    ].contains(routeState.location)) {
      return null;
    }
    log(routeState.location);
    if (Session().isLoggedIn && isAuthenticating) {
      // if logged in redirect to home page
      //TODO : redirect to home when emeregncy call is fixed
      return Routes.announcements2.path;
    } else if (!Session().isLoggedIn && !isAuthenticating) {
      //if not logged in redirect to login page
      return Routes.login.path;
    } else if (routeState.location == Routes.contacts.path) {
      return null;
    }
    return null;
  },
  navigatorBuilder: (context, state, child) {
    return TMBTNotificationListener(child: child);
  },
  routes: [
    GoRoute(
      path: Routes.onboarding.path,
      name: Routes.onboarding.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const OnboardingSlider(),
            ],
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
      path: Routes.announcementsList.path,
      name: Routes.announcementsList.name,
      pageBuilder: (context, routeState) {
        // final appinfoBloc = BlocProvider.of<AppInfoBloc>(context);
        // if (appinfoBloc.state is! FAQState) {
        //   appinfoBloc.add(
        //     const FetchFAQSEvent(),
        //   );
        // }
        return CustomTransitionPage(
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: routeState.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              AnnouncementListPage(
                notifId: routeState.extra is String
                  ? routeState.extra as String
                  : null
              ),
            ],
          ),
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
      path: Routes.announcementsView.path,
      name: Routes.announcementsView.name,
      pageBuilder: (context, routeState) {
        // final appinfoBloc = BlocProvider.of<AppInfoBloc>(context);
        // if (appinfoBloc.state is! FAQState) {
        //   appinfoBloc.add(
        //     const FetchFAQSEvent(),
        //   );
        // }
        AnnouncementModel data = routeState.extra as AnnouncementModel;
        return CustomTransitionPage(
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: routeState.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              AnnouncementViewPage(
                title: data.title ?? "Announcement!",
                description: data.content ?? "Welcome to Timberland Mountain Bike Park Mobile",
                imagePath: data.image ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHwJRHWhpFcogNg6AGOI2Km1AZSeWLKKdE4g&s",
              ),
            ],
          ),
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
      path: Routes.announcements.path,
      name: Routes.announcements.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              AnnouncementsPage(
                announcements: state.extra as List<Announcement>,
              ),
            ],
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
      path: Routes.announcements2.path,
      name: Routes.announcements2.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const AnnouncementPage2(),
            ],
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
      path: Routes.checkoutNotification.path,
      name: Routes.checkoutNotification.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const CheckOutNowPage(),
            ],
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
      path: Routes.login.path,
      name: Routes.login.name,
      pageBuilder: (context, state) {
        return MaterialPage(
          // restorationId: state.pageKey.value,
          key: state.pageKey,
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const LoginPage(),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: Routes.loginVerify.asSubPath(),
          name: Routes.loginVerify.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              restorationId: state.pageKey.value,
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: state.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  OtpVerificationPage<RegisterParameter>(
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
                ],
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
      ],
    ),
    GoRoute(
      path: Routes.forgotPassword.path,
      name: Routes.forgotPassword.name,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const ForgotPasswordPage(),
            ],
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
          path: Routes.forgotPasswordVerify.asSubPath(),
          name: Routes.forgotPasswordVerify.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: state.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  OtpVerificationPage<String>(
                    onSubmit: (otp, parameter) {
                      BlocProvider.of<AuthBloc>(context).add(
                        VerifyForgotPasswordEvent(
                          parameter: parameter,
                          otp: otp,
                        ),
                      );
                    },
                  ),
                ],
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
          path: Routes.resetPassword.asSubPath(),
          name: Routes.resetPassword.name,
          pageBuilder: (context, routeState) {
            return CustomTransitionPage(
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: routeState.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const ResetPasswordPage(),
                ],
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
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: state.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const RegistrationPage(),
            ],
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
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: state.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  InheritedRegisterParameter(
                    registerParameter: state.extra as RegisterParameter,
                    child: const RegistrationContinuationPage(),
                  ),
                ],
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
          path: Routes.registerVerify.asSubPath(),
          name: Routes.registerVerify.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: state.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${state.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  OtpVerificationPage<RegisterParameter>(
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
                ],
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
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: routeState.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const MainPage(
                    selectedTabIndex: 0,
                  ),
                ],
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
              path: Routes.trailMap.path,
              name: Routes.trailMap.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const CustomMapPage(),
                    ],
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
              path: Routes.specificTrail.path,
              name: Routes.specificTrail.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      InheritedTrail(
                        trail: (routeState.extra as Trail),
                        child: const TrailDetails(),
                      ),
                    ],
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
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: routeState.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const MainPage(
                    selectedTabIndex: 1,
                  ),
                ],
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
          path: Routes.profile.asSubPath(),
          name: Routes.profile.name,
          pageBuilder: (context, routeState) {
            return CustomTransitionPage(
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: routeState.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const MainPage(
                    selectedTabIndex: 3,
                  ),
                ],
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
              path: Routes.updateProfile.asSubPath(),
              name: Routes.updateProfile.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      UpdateProfilePage(
                        user: (routeState.extra as User),
                      ),
                    ],
                  ),
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        // opacity: animation,
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ).animate(animation),
                        child: child,
                      ),
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
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const UpdateEmailPage(),
                    ],
                  ),
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        // opacity: animation,
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ).animate(animation),
                        child: child,
                      ),
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
                      child: Stack(
                        children: [
                          // UseFathom().webViewAnalytics(route: routeState.location),
                          WebView(
                            initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                            javascriptMode: JavascriptMode.unrestricted,
                            onWebViewCreated: (WebViewController webViewController) async {
                              // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                              // await webViewController.runJavascript('''
                              //   var script = document.createElement('script');
                              //   script.src = 'https://cdn.usefathom.com/script.js';
                              //   script.setAttribute('data-site', 'CKWVTEIX');
                              //   script.defer = true;
                              //   document.head.appendChild(script);
                              // ''');

                              // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                              await webViewController.runJavascript('''
                                var script = document.createElement('script');
                                script.src = 'https://cdn.usefathom.com/script.js';
                                script.setAttribute('data-site', 'VTLWLMFB');
                                script.defer = true;
                                document.head.appendChild(script);
                              ''');
                              debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                          }),
                          Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                          ),
                          const VerifyUpdateOtpPage(),
                        ],
                      ),
                      transitionDuration: const Duration(milliseconds: 250),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            // opacity: animation,
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0),
                            ).animate(animation),
                            child: child,
                          ),
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
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const UpdatePasswordPage(),
                    ],
                  ),
                  transitionDuration: const Duration(milliseconds: 250),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        // opacity: animation,
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ).animate(animation),
                        child: child,
                      ),
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
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const QrCodePage(),
                    ],
                  ),
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
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const PaymentHistoryPage(),
                    ],
                  ),
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
                    child: Stack(
                      children: [
                        // UseFathom().webViewAnalytics(route: routeState.location),
                        WebView(
                          initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController webViewController) async {
                            // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                            // await webViewController.runJavascript('''
                            //   var script = document.createElement('script');
                            //   script.src = 'https://cdn.usefathom.com/script.js';
                            //   script.setAttribute('data-site', 'CKWVTEIX');
                            //   script.defer = true;
                            //   document.head.appendChild(script);
                            // ''');

                            // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                            await webViewController.runJavascript('''
                              var script = document.createElement('script');
                              script.src = 'https://cdn.usefathom.com/script.js';
                              script.setAttribute('data-site', 'VTLWLMFB');
                              script.defer = true;
                              document.head.appendChild(script);
                            ''');
                            debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                        }),
                        Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                        const BookingHistoryPage(),
                      ],
                    ),
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
                routes: [
                  GoRoute(
                    path: Routes.bookingHistoryDetails.asSubPath(),
                    name: Routes.bookingHistoryDetails.name,
                    pageBuilder: (context, routeState) {
                      return CustomTransitionPage(
                        child: Stack(
                          children: [
                            // UseFathom().webViewAnalytics(route: routeState.location),
                            WebView(
                              initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated: (WebViewController webViewController) async {
                                // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                // await webViewController.runJavascript('''
                                //   var script = document.createElement('script');
                                //   script.src = 'https://cdn.usefathom.com/script.js';
                                //   script.setAttribute('data-site', 'CKWVTEIX');
                                //   script.defer = true;
                                //   document.head.appendChild(script);
                                // ''');

                                // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                await webViewController.runJavascript('''
                                  var script = document.createElement('script');
                                  script.src = 'https://cdn.usefathom.com/script.js';
                                  script.setAttribute('data-site', 'VTLWLMFB');
                                  script.defer = true;
                                  document.head.appendChild(script);
                                ''');
                                debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                            }),
                            Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                            ),
                            BookingHistoryDetails(
                              bookingHistory: routeState.extra as BookingHistory,
                            ),
                          ],
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
                ]),
          ],
        ),
        GoRoute(
          path: Routes.booking.asSubPath(),
          name: Routes.booking.name,
          pageBuilder: (context, routeState) {
            return CustomTransitionPage(
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: routeState.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const MainPage(
                    selectedTabIndex: 2,
                  ),
                ],
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
                final BookingRequestParams name = routeState.extra as BookingRequestParams;
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      BookingWaiver(
                        bookingRequestParams: name,
                      ),
                    ],
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
              path: Routes.checkout.asSubPath(),
              name: Routes.checkout.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const CheckoutPage(),
                    ],
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
              path: Routes.successfulBooking.asSubPath(),
              name: Routes.successfulBooking.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const SuccessBookingPage(),
                    ],
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
              path: Routes.failedfulBooking.asSubPath(),
              name: Routes.failedfulBooking.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const FailedBookingPage(),
                    ],
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
              path: Routes.cancelledfulBooking.asSubPath(),
              name: Routes.cancelledfulBooking.name,
              pageBuilder: (context, routeState) {
                return CustomTransitionPage(
                  child: Stack(
                    children: [
                      // UseFathom().webViewAnalytics(route: routeState.location),
                      WebView(
                        initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) async {
                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                          // await webViewController.runJavascript('''
                          //   var script = document.createElement('script');
                          //   script.src = 'https://cdn.usefathom.com/script.js';
                          //   script.setAttribute('data-site', 'CKWVTEIX');
                          //   script.defer = true;
                          //   document.head.appendChild(script);
                          // ''');

                          // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                          await webViewController.runJavascript('''
                            var script = document.createElement('script');
                            script.src = 'https://cdn.usefathom.com/script.js';
                            script.setAttribute('data-site', 'VTLWLMFB');
                            script.defer = true;
                            document.head.appendChild(script);
                          ''');
                          debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                      }),
                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      const CancelledBookingPage(),
                    ],
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
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: routeState.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const FAQsPage(),
            ],
          ),
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
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: routeState.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              const ContactsPage(),
            ],
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
          path: Routes.contactSuccess.asSubPath(),
          name: Routes.contactSuccess.name,
          pageBuilder: (context, routeState) {
            return CustomTransitionPage(
              key: routeState.pageKey,
              restorationId: routeState.pageKey.value,
              child: Stack(
                children: [
                  // UseFathom().webViewAnalytics(route: routeState.location),
                  WebView(
                    initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) async {
                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                      // await webViewController.runJavascript('''
                      //   var script = document.createElement('script');
                      //   script.src = 'https://cdn.usefathom.com/script.js';
                      //   script.setAttribute('data-site', 'CKWVTEIX');
                      //   script.defer = true;
                      //   document.head.appendChild(script);
                      // ''');

                      // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                      await webViewController.runJavascript('''
                        var script = document.createElement('script');
                        script.src = 'https://cdn.usefathom.com/script.js';
                        script.setAttribute('data-site', 'VTLWLMFB');
                        script.defer = true;
                        document.head.appendChild(script);
                      ''');
                      debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
                  }),
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  const ContactUsThankyouPage(),
                ],
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
      path: Routes.emergency.path,
      name: Routes.emergency.name,
      pageBuilder: (context, routeState) {
        return CustomTransitionPage(
          key: routeState.pageKey,
          restorationId: routeState.pageKey.value,
          child: Stack(
            children: [
              // UseFathom().webViewAnalytics(route: routeState.location),
              WebView(
                initialUrl: 'https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  await webViewController.runJavascript('''
                    var script = document.createElement('script');
                    script.src = 'https://cdn.usefathom.com/script.js';
                    script.setAttribute('data-site', 'VTLWLMFB');
                    script.defer = true;
                    document.head.appendChild(script);
                  ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://management.timberlandresort.com/mobile-analytics/dev-mode${routeState.location}');
              }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              EmergencyPage(
                callDirection: (routeState.extra as CallDirection?) ?? CallDirection.outgoing,
              ),
            ],
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
