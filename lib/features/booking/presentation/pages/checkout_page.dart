import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/presentation/widgets/timberland_scaffold.dart';
import '../bloc/booking_bloc.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late WebViewController _controller;
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
        extendBodyBehindAppbar: true,
        disableBackButton: true,
        physics: const NeverScrollableScrollPhysics(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: WebView(
            initialUrl: state.checkoutHtml,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}
