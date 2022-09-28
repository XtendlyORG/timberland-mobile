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

void showToast(String message) {
  _easyLoading(
    callback: () => EasyLoading.showToast(
      message,
      toastPosition: EasyLoadingToastPosition.bottom,
    ),
  );
}

void noNetworkToast() {
  EasyLoading.showToast(
    "No Internet Connection",
    duration: const Duration(days: 1),
    dismissOnTap: false,
    toastPosition: EasyLoadingToastPosition.bottom,
  );
}

void _easyLoading({required VoidCallback callback}) {
  EasyLoading.dismiss();
  callback();
  if (!InternetConnectivity().internetConnected) {}
}
