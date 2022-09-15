import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:timberland_biketrail/core/constants/padding.dart';
import 'package:timberland_biketrail/core/presentation/widgets/dialogs/custom_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/router/router.dart';
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

  @override
  Widget build(BuildContext context) {
    final state =
        BlocProvider.of<BookingBloc>(context).state as BookingSubmitted;
    return WillPopScope(
      onWillPop: () async {
        if (!(await _controller.canGoBack())) {
          Navigator.pop(context);
          context.pushNamed(Routes.cancelledfulBooking.name);
        } else {
          MoveToBackground.moveTaskToBack();
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Checkout"),
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
                  setState(() {
                    progress = loadingProgress;
                  });
                },
                navigationDelegate: (request) {
                  if (request.url.contains('success')) {
                    Navigator.pop(context);
                    context.pushNamed(Routes.successfulBooking.name);
                    return NavigationDecision.prevent;
                  }
                  if (request.url.contains('fail')) {
                    Navigator.pop(context);
                    context.pushNamed(Routes.failedfulBooking.name);
                    return NavigationDecision.prevent;
                  }
                  if (request.url.contains('cancel')) {
                    Navigator.pop(context);
                    context.pushNamed(Routes.cancelledfulBooking.name);
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
