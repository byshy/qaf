import 'dart:convert';

import 'package:qaf/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepo {
  final SharedPreferences sharedPreferences;

  LocalRepo({required this.sharedPreferences});

  static const _user = 'user';

  Future<void> setUser(User user) {
    String userJson = jsonEncode(user);
    return sharedPreferences.setString(_user, userJson);
  }

  Future<void> setUserData(UserInfo userdata) {
    User? user = getUser();
    user?.data?.userInfo = userdata;

    String userJson = jsonEncode(user);
    return sharedPreferences.setString(_user, userJson);
  }

  User? getUser() {
    String? user = sharedPreferences.getString(_user);
    if (user != null) {
      var map = jsonDecode(user);
      return User.fromJson(map);
    }
    return null;
  }

  void removeUser() {
    sharedPreferences.remove(_user);
  }

  static const _languange = 'language';

  Future<void> setLanguage(String value) {
    return sharedPreferences.setString(_languange, value);
  }

  String? getLanguage() {
    return sharedPreferences.getString(_languange);
  }
}
