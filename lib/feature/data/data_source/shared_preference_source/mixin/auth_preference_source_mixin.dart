import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

mixin AuthPreferenceSourceMixin {
  static const String login = "LOGIN";
  static const String password = "PASSWORD";

  late final SharedPreferences sharedPreferences;
  late final FlutterSecureStorage flutterSecureStorage;

  Future<void> setLogin(String param) async {
    sharedPreferences.setString(login, param);
  }

  Future<String?> getLogin(String param) async {
    return sharedPreferences.getString(login);
  }

  Future<void> setPassword(String param) async {
    flutterSecureStorage.write(key: password, value: param);
  }

  Future<String?> getPassword(String param) async {
    return flutterSecureStorage.read(key: password);
  }

}
