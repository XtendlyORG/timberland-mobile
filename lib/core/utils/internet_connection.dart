import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/models/user_model.dart';
import '../../features/authentication/domain/entities/user.dart';

class InternetConnectivity extends ChangeNotifier {
  static final InternetConnectivity _instance = InternetConnectivity._();
  InternetConnectivity._();
  factory InternetConnectivity() => _instance;

  late bool _internetConnected;
  bool get internetConnected => _internetConnected;
  late GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey;
  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  final _connectivity = Connectivity();

  Future<void> init() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();

    _scaffoldMessengerKey = GlobalKey();
    await _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) async {
      await _checkStatus(result);
    });
  }

  Future<void> _checkStatus(ConnectivityResult result) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      _internetConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      _internetConnected = false;
    }
    notifyListeners();
  }
}
