import 'package:shared_preferences/shared_preferences.dart';

mixin PermissionPreferenceSourceMixin {
  static const String permission = "PERMISSION";

  late final SharedPreferences sharedPreferences;

  Future<void> setPermission(bool params) async {
    sharedPreferences.setBool(permission, params);
  }

  Future<bool> getPermission() async {
    return sharedPreferences.getBool(permission) ?? true;
  }
}
