import 'dart:convert';

import 'package:encrypt/encrypt.dart' as crypt;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/data/models/user_model.dart';
import '../../features/authentication/domain/entities/user.dart';

class Session extends ChangeNotifier {
  static final Session _instance = Session._();
  final _encryptorKey = crypt.Key.fromLength(32);
  final _iv = crypt.IV.fromLength(8);
  late final crypt.Encrypter encrypter;

  Session._();
  factory Session() => _instance;

  late SharedPreferences _prefs;

  late bool _isLoggedIn;
  late User? _currentUser;
  late DateTime? _lockAuthUntil;

  late String? _latestAnnouncementID;

  String? get latestAnnouncementID => _latestAnnouncementID;

  bool get isLoggedIn => _isLoggedIn;
  User? get currentUser => _currentUser;
  DateTime? get lockAuthUntil => _lockAuthUntil;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    encrypter = crypt.Encrypter(crypt.Salsa20(_encryptorKey));
    _isLoggedIn = false;
    final encryptedUserJson = _prefs.getString(_PrefKeys.uid);
    final userJson = encryptedUserJson != null ? _decryptString(encryptedUserJson) : null;
    _currentUser = null;
    if (userJson != null) {
      _currentUser = UserModel.fromMap(json.decode(userJson));
    }
    final encryptedLockUntil = _prefs.getString(_PrefKeys.lockAuthUntil) ?? '';

    final lockUntil = DateTime.tryParse(_decryptString(encryptedLockUntil));

    _lockAuthUntil = (lockUntil?.difference(DateTime.now()).inSeconds ?? -1) <= 0 ? null : lockUntil;

    final announcementID = _prefs.getString(_PrefKeys.announcementID);

    _latestAnnouncementID = announcementID == null ? null : _decryptString(announcementID);
  }

  void login(User user) {
    _prefs.setBool(_PrefKeys.isLoggedIn, true);
    _isLoggedIn = true;
    _prefs.setString(_PrefKeys.uid, _encryptString(user.toJson()));
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
    await _prefs.setString(_PrefKeys.lockAuthUntil, _encryptString(_lockAuthUntil!.toIso8601String()));
  }

  Future<bool> saveFCMToken(String fcmToken) async {
    return _prefs.setString(_PrefKeys.fcmToken, _encryptString(fcmToken));
  }

  String? getFCMToken() {
    final encryptedToken = _prefs.getString(_PrefKeys.fcmToken);
    if (encryptedToken == null) return null;
    return _decryptString(encryptedToken);
  }

  void saveLatestAnnouncement(String id) {
    _prefs.setString(_PrefKeys.announcementID, _encryptString(id));
  }

  String _encryptString(String text) {
    return encrypter.encrypt(text, iv: _iv).base64;
  }

  String _decryptString(String text) {
    return encrypter.decrypt(crypt.Encrypted.fromBase64(text), iv: _iv);
  }

  void updateUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void performAutoLogin() {
    _isLoggedIn = true;
    notifyListeners();
  }
}

abstract class _PrefKeys {
  static const isLoggedIn = 'isLoggedIn';
  static const uid = 'UID';
  static const lockAuthUntil = 'lockAuthUntil';
  static const fcmToken = 'FCM_TOKEN';

  static const announcementID = 'ANNOUNCEMENT_ID';
}
