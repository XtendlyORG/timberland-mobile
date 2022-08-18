import 'package:flutter/material.dart';

import '../../../utils/internet_connection.dart';
import 'no_network_snackbar.dart';

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
