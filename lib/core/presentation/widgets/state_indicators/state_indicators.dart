import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

import '../../../utils/internet_connection.dart';

void showLoading(String loadingMessage) {
  _easyLoading(
    callback: () => EasyLoading.show(
      status: loadingMessage,
      indicator: Platform.isIOS
          ? const CircularProgressIndicator.adaptive(
              backgroundColor: TimberlandColor.background,
            )
          : null,
    ),
  );
}

void showError(String errorMessage) {
  _easyLoading(callback: () => EasyLoading.showError(errorMessage));
}

showInfo(String message) {
  _easyLoading(callback: () => EasyLoading.showInfo(message));
}

void showSuccess(String message) {
  _easyLoading(callback: () => EasyLoading.showSuccess(message));
}

void showFloatingToast(BuildContext context, String message) {
  _easyLoading(callback: () {
    ScaffoldMessenger.of(context)
      ..clearSnackBars
      ..showSnackBar(
        SnackBar(
          elevation: 2,
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.black.withOpacity(.9),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      );
  });
}

void showToast(String message, {EasyLoadingToastPosition? toastPosition}) {
  _easyLoading(
    callback: () => EasyLoading.showToast(
      message,
      toastPosition: toastPosition ?? EasyLoadingToastPosition.bottom,
    ),
  );
}

void noNetworkToast(BuildContext context) {
  showFloatingToast(
    context,
    "No Internet Connection",
  );
}

void _easyLoading({required VoidCallback callback}) {
  EasyLoading.dismiss();
  callback();
  if (!InternetConnectivity().internetConnected) {}
}
