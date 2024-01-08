import 'package:shared_preferences/shared_preferences.dart';

mixin NotificationPreferenceSourceMixin {
  static const String notification = "NOTIFICATION";

  late final SharedPreferences sharedPreferences;

  Future<void> setNotification(bool params) async {
    sharedPreferences.setBool(notification, params);
  }

  Future<bool> getNotification() async {
    return sharedPreferences.getBool(notification) ?? true;
  }




}
