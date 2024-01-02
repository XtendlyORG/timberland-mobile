import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:timberland_biketrail/core/configs/environment_configs.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/router/router.dart';
import '../../../../dependency_injection/app_info_depencency.dart';
import '../bloc/booking_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late WebViewController _controller;
  int progress = 0;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  Future makeApiCall(id, status) async {
    String apiHost = serviceLocator<EnvironmentConfig>().apihost;

    log('the api host: $apiHost/payments/$status');
    try {
      final response = await Dio().post(
        '$apiHost/payments/$status?id=$id',
      );
      if (response.statusCode == 200) {
        log('the response: ${response.data}');
        if (status == 'success') {
          Navigator.pop(context);
          context.pushNamed(Routes.successfulBooking.name);
        } else if (status == 'failure') {
          Navigator.pop(context);
          context.pushNamed(Routes.failedfulBooking.name);
        } else {
          Navigator.pop(context);
          context.pushNamed(Routes.cancelledfulBooking.name);
        }
      }
      // handle the response here
    } on DioError catch (e) {
      log('the error: ${e.response}');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<BookingBloc>(context).state as BookingSubmitted;
    return WillPopScope(
      onWillPop: () async {
        if (!(await _controller.canGoBack())) {
          Navigator.pop(context);
          context.pushNamed(Routes.booking.name);
        } else {
          MoveToBackground.moveTaskToBack();
        }
        return false;
      },
      child: DecoratedSafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Checkout"),
            leading: IconButton(
              onPressed: () async {
                String id = state.checkoutHtml.split('?id=')[1];
                await makeApiCall(id, "cancel");
                // context.pushNamed(Routes.cancelledfulBooking.name);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Stack(
            children: [
              WebView(
                initialUrl: state.checkoutHtml,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (ctrl) {
                  _controller = ctrl;
                },
                // onPageFinished: (val) {
                //   // CODE LOGIC FOR GETTING THE CHECKOUT PAGE'S DATA AS JSON

                //   // _controller
                //   //     .runJavascriptReturningResult(
                //   //         'document.body.getElementsByTagName("script")[0].outerHTML')
                //   //     .then((scriptTag) {
                //   //   final _json = readCheckOutPageAsJson(scriptTag);
                //   //   log(_json.toString());
                //   // });
                // },
                onProgress: (loadingProgress) {
                  if (mounted && progress != 100) {
                    setState(() {
                      progress = loadingProgress;
                    });
                  }
                },
                navigationDelegate: (request) async {
                  String id = request.url.split('?id=')[1];

                  log('the current url: ${request.url}');
                  log('the id: $id');

                  if (request.url.contains('success')) {
                    await makeApiCall(id, 'success');

                    return NavigationDecision.prevent;
                  }
                  if (request.url.contains('fail')) {
                    await makeApiCall(id, 'failure');

                    return NavigationDecision.prevent;
                  }
                  if (request.url.contains('cancel')) {
                    await makeApiCall(id, 'cancel');

                    return NavigationDecision.prevent;
                  }

                  return NavigationDecision.navigate;
                },
              ),
              if (progress < 100)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator.adaptive(
                        value: progress / 100,
                      ),
                      const SizedBox(
                        height: kVerticalPadding,
                      ),
                      Text(
                        'Please wait...',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Map<String, dynamic> readCheckOutPageAsJson(String scriptTag) {
  //   final jsonString = scriptTag
  //       .substring(scriptTag.indexOf('{'), scriptTag.lastIndexOf(';'))
  //       .replaceAll("\\", '');

  //   return json.decode(jsonString);
  // }
}
