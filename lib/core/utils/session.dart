import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session extends ChangeNotifier {
  static final Session _instance = Session._();
  Session._();
  factory Session() => _instance;

  late SharedPreferences _prefs;

  late bool _isLoggedIn;
  late String? _currentUID;

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUID => _currentUID;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _isLoggedIn = _prefs.getBool(_PrefKeys.isLoggedIn) ?? false;
    _currentUID = _prefs.getString(_PrefKeys.uid);
  }

  void login(String uid) {
    _prefs.setBool(_PrefKeys.isLoggedIn, true);
    _isLoggedIn = true;
    _prefs.setString(_PrefKeys.uid, uid);
    _currentUID = uid;
    notifyListeners();
  }

  void logout() {
    _prefs.setBool(_PrefKeys.isLoggedIn, false);
    _isLoggedIn = false;
    _prefs.remove(_PrefKeys.uid);
    _currentUID = null;
    notifyListeners();
  }
}

abstract class _PrefKeys {
  static const isLoggedIn = 'isLoggedIn';
  static const uid = 'UID';
}
