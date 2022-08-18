import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/snackbar_content/no_network_snackbar.dart';
import 'package:timberland_biketrail/core/utils/internet_connection.dart';

void showSnackBar(
  SnackBar snackBar,
) {
  InternetConnectivity().scaffoldMessengerKey.currentState
    ?..clearSnackBars
    ..showSnackBar(snackBar);
    
  if (!InternetConnectivity().internetConnected) {
    InternetConnectivity()
        .scaffoldMessengerKey
        .currentState
        ?.showSnackBar(noNetworkSnackBar);
  }
}
