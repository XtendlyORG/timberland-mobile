import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timberland_biketrail/features/authentication/data/models/user_model.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

class Session extends ChangeNotifier {
  static final Session _instance = Session._();
  Session._();
  factory Session() => _instance;

  late SharedPreferences _prefs;

  late bool _isLoggedIn;
  late User? _currentUser;
  late DateTime? _lockAuthUntil;

  bool get isLoggedIn => _isLoggedIn;
  User? get currentUser => _currentUser;
  DateTime? get lockAuthUntil => _lockAuthUntil;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = false;
    final userJson = _prefs.getString(_PrefKeys.uid);
    _currentUser = null;
    if (userJson != null) {
      _currentUser = UserModel.fromMap(json.decode(userJson));
    }

    final lockUntil =
        DateTime.tryParse(_prefs.getString(_PrefKeys.lockAuthUntil) ?? '');

    _lockAuthUntil =
        (lockUntil?.difference(DateTime.now()).inSeconds ?? -1) <= 0
            ? null
            : lockUntil;
  }

  void login(User user) {
    _prefs.setBool(_PrefKeys.isLoggedIn, true);
    _isLoggedIn = true;
    _prefs.setString(_PrefKeys.uid, user.toJson());
    _currentUser = user;
    notifyListeners();
  }

  void logout() {
    _prefs.setBool(_PrefKeys.isLoggedIn, false);
    _isLoggedIn = false;
    _prefs.remove(_PrefKeys.uid);
    _currentUser = null;
    notifyListeners();
  }

  void fingerprintAuthenticated() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void unlockAuth() {
    _lockAuthUntil = null;
    _prefs.remove(_PrefKeys.lockAuthUntil);
  }

  void lockAuth({required Duration duration}) async {
    _lockAuthUntil = DateTime.now().add(duration);
    await _prefs.setString(
        _PrefKeys.lockAuthUntil, _lockAuthUntil!.toIso8601String());
  }
}

abstract class _PrefKeys {
  static const isLoggedIn = 'isLoggedIn';
  static const uid = 'UID';
  static const lockAuthUntil = 'lockAuthUntil';
}
