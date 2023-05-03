import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/constants.dart';
import '../../model/auth/login_response.dart';

@injectable
class AppPreferences {
  final String _isDarkMode = 'isDarkMode';
  final String _lang = 'lang';
  final String _isLogin = 'isLogin';
  final String _userToken = 'userToken';
  final String _userData = 'userData';
  final String _lastStoreSearch = 'lastStoreSearch';
  final String _lastProductSearch = 'lastProductSearch';
  final String _isLanguageSelected = 'isLanguageSelected';

  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<bool> _putData(String key, dynamic value) async {
    if (value is String) return await _sharedPreferences.setString(key, value);
    if (value is int) return await _sharedPreferences.setInt(key, value);
    return await _sharedPreferences.setBool(key, value);
  }

  dynamic _getData(String key, dynamic def) {
    var value = _sharedPreferences.get(key);
    return value ?? def;
  }

  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  String get lang => _getData(_lang, Constants.defaultLanguage);

  set lang(String value) {
    _putData(_lang, value);
  }

  bool get isDarkMode => _getData(_isDarkMode, true);

  set isDarkMode(bool value) {
    _putData(_isDarkMode, value);
  }

  bool get isLanguageSelected => _getData(_isLanguageSelected, false);

  set isLanguageSelected(bool value) {
    _putData(_isLanguageSelected, value);
  }

  bool get isUserLogin => _getData(_userToken, "").isNotEmpty;

  String get userToken => _getData(_userToken, "");

  set userToken(String value) {
    _putData(_userToken, value);
  }

// user data
  UserModel? get userData {
    String data = _getData(_userData, "");
    if (data.isEmpty) return null;
    return UserModel.fromJson(jsonDecode(_getData(_userData, null)));
  }

  set userData(UserModel? user) {
    _putData(_userData, jsonEncode(user));
  } // user data

  // SearchText? get lastStoreSearch {
  //   String data = _getData(_lastStoreSearch, "");
  //   if (data.isEmpty) return null;
  //   return SearchText.fromJson(jsonDecode(_getData(_lastStoreSearch, null)));
  // }
  //
  // set lastStoreSearch(SearchText? text) {
  //   _putData(_lastStoreSearch, jsonEncode(text));
  // } // user data
  //
  // SearchText? get lastProductSearch {
  //   String data = _getData(_lastProductSearch, "");
  //   if (data.isEmpty) return null;
  //   return SearchText.fromJson(jsonDecode(_getData(_lastProductSearch, null)));
  // }
  //
  // set lastProductSearch(SearchText? text) {
  //   _putData(_lastProductSearch, jsonEncode(text));
  // } // user data
}
