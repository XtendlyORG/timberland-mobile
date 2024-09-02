// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/incoming_call_notif_dialog.dart';

import 'core/configs/environment_configs.dart';
import 'core/constants/navbar_configs.dart';
import 'core/presentation/widgets/bottom_navbar.dart';
import 'core/presentation/widgets/decorated_safe_area.dart';
import 'core/presentation/widgets/timberland_appbar.dart';
import 'core/presentation/widgets/timberland_container.dart';
import 'core/router/routes.dart';
import 'dashboard/presentation/pages/profile_page.dart';
import 'dashboard/presentation/widgets/dashboard.dart';
import 'dashboard/presentation/widgets/profile_settings.dart';
import 'features/app_infos/presentation/pages/trail_rules.dart';
import 'features/booking/presentation/pages/booking_page.dart';
import 'features/trail/presentation/pages/trail_directory.dart';

class MainPage extends StatefulWidget {
  final int selectedTabIndex;
  const MainPage({
    Key? key,
    required this.selectedTabIndex,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late int currentIndex;
  late PageController pageController;

  AnimationController? ctrl;

  final serviceLocator = GetIt.instance;
  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
    );
    currentIndex = widget.selectedTabIndex;
    pageController = PageController(
      initialPage: currentIndex,
      keepPage: true,
    );
  }

  Future<bool?> verifyToken(Dio dioClient, EnvironmentConfig environmentConfig) async {
    const storage = FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    dioClient.options.headers["authorization"] = "token $token";
    var refreshToken = await storage.read(key: 'refreshToken');
    log('OLD TOKEN: $token');
    log('OLD REFRESH TOKEN: $refreshToken');
    final response = await dioClient.post(
      '${environmentConfig.apihost}/members/accessToken/refresh',
      data: {'refreshCode': refreshToken},
    );
    log("REFRESH TOKEN HAS BEEN REFRESHED");

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('NEW TOKEN: ${response.data['token']}');
      log('NEW REFRESH TOKEN: ${response.data['refreshCode']}');

      if (response.data['token'] != null) {
        await storage.write(key: 'token', value: response.data['token']);
      } else {
        await storage.write(key: 'token', value: response.data['accessToken']);
      }
      await storage.write(key: 'refreshToken', value: response.data['refreshCode']);
      return true;
    } else {
      //logout
      final Session session = Session();
      session.logout();
      BlocProvider.of<AuthBloc>(context).add(const LogoutEvent());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex != widget.selectedTabIndex) {
      currentIndex = widget.selectedTabIndex;
      pageController.jumpToPage(
        currentIndex,
      );
    }

    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state is IncomingCallNotification) {
          log('showing dialog of incoming call');
          showDialog(
              context: context,
              builder: (builder) {
                return IncomingCallNotifDialog(
                  incomingCallNotifCtrl: ctrl!,
                  configs: state.configs,
                );
              });
        }
      },
      child: FutureBuilder(
          future: verifyToken(serviceLocator(), serviceLocator()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  if (current is UserGuideFinished) {
                    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                      context.goNamed(Routes.booking.name);
                    });
                  }
                  return current is! UnAuthenticated;
                },
                builder: (context, state) {
                  if (state is UnAuthenticated && Session().isLoggedIn) {
                    Future.delayed(Duration.zero, () {
                      BlocProvider.of<AuthBloc>(context).add(
                        const FetchUserEvent(),
                      );
                    });
                  }
                  if (state is Authenticated) {
                    if (state.firstTimeUser) {
                      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                        ScaffoldMessenger.of(context).clearSnackBars();
                        context.goNamed(Routes.onboarding.name);
                      });
                      return const Scaffold();
                    }

                    return WillPopScope(
                      onWillPop: () async {
                        MoveToBackground.moveTaskToBack();
                        return false;
                      },
                      child: DecoratedSafeArea(
                        child: Scaffold(
                          endDrawer: const Dashboard(),
                          appBar: TimberlandAppbar(
                            actions: currentIndex == 3
                                ? [
                                    ProfileSettingsButton(
                                      user: state.user,
                                    ),
                                  ]
                                : null,
                          ),
                          extendBodyBehindAppBar: true,
                          bottomNavigationBar: BottomNavBar(
                            index: currentIndex,
                            configs: navbarConfigs,
                            onTap: (index) {
                              pageController.jumpToPage(
                                index,
                              );
                            },
                          ),
                          body: TimberlandContainer(
                            child: RepaintBoundary(
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return SizedBox(
                                    height: constraints.maxHeight,
                                    child: PageView(
                                      controller: pageController,
                                      onPageChanged: (index) {
                                        // dismis keyboard
                                        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

                                        currentIndex = index;

                                        context.goNamed(
                                          navbarConfigs[currentIndex].routeName,
                                        );
                                      },
                                      children: [
                                        RepaintBoundary(
                                          child: Stack(
                                            children: [
                                              // UseFathom().webViewAnalytics(route: routeState.location),
                                              InAppWebView(
                                                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://timberland.xtendly.com/mobile-analytics/dev-mode/trails'))),
                                                onWebViewCreated: (webViewController) async {
                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                                  // await webViewController.runJavascript('''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'CKWVTEIX');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');

                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                                  // await webViewController.evaluateJavascript(source:'''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'VTLWLMFB');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');
                                                  debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/trails');
                                                }
                                              ),
                                              // WebView(
                                              //   initialUrl: 'https://timberland.xtendly.com/mobile-analytics/dev-mode/trails',
                                              //   javascriptMode: JavascriptMode.unrestricted,
                                              //   onWebViewCreated: (WebViewController webViewController) async {
                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                              //     // await webViewController.runJavascript('''
                                              //     //   var script = document.createElement('script');
                                              //     //   script.src = 'https://cdn.usefathom.com/script.js';
                                              //     //   script.setAttribute('data-site', 'CKWVTEIX');
                                              //     //   script.defer = true;
                                              //     //   document.head.appendChild(script);
                                              //     // ''');

                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                              //     await webViewController.runJavascript('''
                                              //       var script = document.createElement('script');
                                              //       script.src = 'https://cdn.usefathom.com/script.js';
                                              //       script.setAttribute('data-site', 'VTLWLMFB');
                                              //       script.defer = true;
                                              //       document.head.appendChild(script);
                                              //     ''');
                                              //     debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/trails');
                                              // }),
                                              Container(
                                                color: Colors.white,
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height,
                                              ),
                                              const TrailDirectory(),
                                            ],
                                          ),
                                        ),
                                        RepaintBoundary(
                                          child: Stack(
                                            children: [
                                              // UseFathom().webViewAnalytics(route: routeState.location),
                                              InAppWebView(
                                                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://timberland.xtendly.com/mobile-analytics/dev-mode/rules'))),
                                                onWebViewCreated: (webViewController) async {
                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                                  // await webViewController.runJavascript('''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'CKWVTEIX');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');

                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                                  // await webViewController.evaluateJavascript(source:'''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'VTLWLMFB');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');
                                                  debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/rules');
                                                }
                                              ),
                                              // WebView(
                                              //   initialUrl: 'https://timberland.xtendly.com/mobile-analytics/dev-mode/rules',
                                              //   javascriptMode: JavascriptMode.unrestricted,
                                              //   onWebViewCreated: (WebViewController webViewController) async {
                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                              //     // await webViewController.runJavascript('''
                                              //     //   var script = document.createElement('script');
                                              //     //   script.src = 'https://cdn.usefathom.com/script.js';
                                              //     //   script.setAttribute('data-site', 'CKWVTEIX');
                                              //     //   script.defer = true;
                                              //     //   document.head.appendChild(script);
                                              //     // ''');

                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                              //     await webViewController.runJavascript('''
                                              //       var script = document.createElement('script');
                                              //       script.src = 'https://cdn.usefathom.com/script.js';
                                              //       script.setAttribute('data-site', 'VTLWLMFB');
                                              //       script.defer = true;
                                              //       document.head.appendChild(script);
                                              //     ''');
                                              //     debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/rules');
                                              // }),
                                              Container(
                                                color: Colors.white,
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height,
                                              ),
                                              const TrailRulesPage(),
                                            ],
                                          ),
                                        ),
                                        RepaintBoundary(
                                          child: Stack(
                                            children: [
                                              // UseFathom().webViewAnalytics(route: routeState.location),
                                              InAppWebView(
                                                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://timberland.xtendly.com/mobile-analytics/dev-mode/booking'))),
                                                onWebViewCreated: (webViewController) async {
                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                                  // await webViewController.runJavascript('''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'CKWVTEIX');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');

                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                                  // await webViewController.evaluateJavascript(source:'''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'VTLWLMFB');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');
                                                  debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/booking');
                                                }
                                              ),
                                              // WebView(
                                              //   initialUrl: 'https://timberland.xtendly.com/mobile-analytics/dev-mode/booking',
                                              //   javascriptMode: JavascriptMode.unrestricted,
                                              //   onWebViewCreated: (WebViewController webViewController) async {
                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                              //     // await webViewController.runJavascript('''
                                              //     //   var script = document.createElement('script');
                                              //     //   script.src = 'https://cdn.usefathom.com/script.js';
                                              //     //   script.setAttribute('data-site', 'CKWVTEIX');
                                              //     //   script.defer = true;
                                              //     //   document.head.appendChild(script);
                                              //     // ''');

                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                              //     await webViewController.runJavascript('''
                                              //       var script = document.createElement('script');
                                              //       script.src = 'https://cdn.usefathom.com/script.js';
                                              //       script.setAttribute('data-site', 'VTLWLMFB');
                                              //       script.defer = true;
                                              //       document.head.appendChild(script);
                                              //     ''');
                                              //     debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/booking');
                                              // }),
                                              Container(
                                                color: Colors.white,
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height,
                                              ),
                                              const BookingPage(),
                                            ],
                                          ),
                                        ),
                                        RepaintBoundary(
                                          child: Stack(
                                            children: [
                                              // UseFathom().webViewAnalytics(route: routeState.location),
                                              InAppWebView(
                                                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://timberland.xtendly.com/mobile-analytics/dev-mode/profile'))),
                                                onWebViewCreated: (webViewController) async {
                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                                  // await webViewController.runJavascript('''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'CKWVTEIX');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');

                                                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                                  // await webViewController.evaluateJavascript(source:'''
                                                  //   var script = document.createElement('script');
                                                  //   script.src = 'https://cdn.usefathom.com/script.js';
                                                  //   script.setAttribute('data-site', 'VTLWLMFB');
                                                  //   script.defer = true;
                                                  //   document.head.appendChild(script);
                                                  // ''');
                                                  debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/profile');
                                                }
                                              ),
                                              // WebView(
                                              //   initialUrl: 'https://timberland.xtendly.com/mobile-analytics/dev-mode/profile',
                                              //   javascriptMode: JavascriptMode.unrestricted,
                                              //   onWebViewCreated: (WebViewController webViewController) async {
                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                                              //     // await webViewController.runJavascript('''
                                              //     //   var script = document.createElement('script');
                                              //     //   script.src = 'https://cdn.usefathom.com/script.js';
                                              //     //   script.setAttribute('data-site', 'CKWVTEIX');
                                              //     //   script.defer = true;
                                              //     //   document.head.appendChild(script);
                                              //     // ''');

                                              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                                              //     await webViewController.runJavascript('''
                                              //       var script = document.createElement('script');
                                              //       script.src = 'https://cdn.usefathom.com/script.js';
                                              //       script.setAttribute('data-site', 'VTLWLMFB');
                                              //       script.defer = true;
                                              //       document.head.appendChild(script);
                                              //     ''');
                                              //     debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/profile');
                                              // }),
                                              Container(
                                                color: Colors.white,
                                                width: MediaQuery.of(context).size.width,
                                                height: MediaQuery.of(context).size.height,
                                              ),
                                              const ProfilePage(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SafeArea(
                    child: Scaffold(
                      body: TimberlandContainer(
                        child: Center(
                          child: RepaintBoundary(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: RepaintBoundary(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
