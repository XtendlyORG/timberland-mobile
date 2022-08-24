import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/presentation/widgets/drawer_iconbutton.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';
import '../bloc/booking_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // late WebViewController _controller;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    final state =
        BlocProvider.of<BookingBloc>(context).state as BookingSubmitted;
    return SafeArea(
      child: TimberlandScaffold(
        disableBackButton: true,
        index: 2,
        physics: const NeverScrollableScrollPhysics(),
        appBar: AppBar(
          title: const Text('Checkout'),
          actions: const [DrawerIconButton()],
        ),
        body: BlocListener<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingCreated) {
              Navigator.pop(context);
              context.pushNamed(Routes.successfulBooking.name);
            }
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight * 2,
            child: WebView(
              initialUrl: state.checkoutHtml,
              javascriptMode: JavascriptMode.unrestricted,
              // onWebViewCreated: (ctrl) {
              //   _controller = ctrl;
              // },
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
              navigationDelegate: (request) {
                log(request.url);

                if (request.url.contains('success')) {
                  BlocProvider.of<BookingBloc>(context).add(CreateBookingEvent(
                    parameter: state.bookingParameter,
                  ));
                  return NavigationDecision.prevent;
                }
                if (request.url.contains('fail')) {
                  return NavigationDecision.prevent;
                }
                if (request.url.contains('cancel')) {
                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
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
