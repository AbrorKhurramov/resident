import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:resident/app_package/data/data_source_package.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'mixin/permission_preference_source_mixin.dart';

abstract class AppPreferenceSource
    implements
        LanguagePreferenceSourceMixin,
        AuthPreferenceSourceMixin,
        PinCodePreferenceSourceMixin,
        PermissionPreferenceSourceMixin,
        NotificationPreferenceSourceMixin {}

class AppPreferenceSourceImpl
    with
        LanguagePreferenceSourceMixin,
        AuthPreferenceSourceMixin,
        PinCodePreferenceSourceMixin,
        PermissionPreferenceSourceMixin,
        NotificationPreferenceSourceMixin
    implements AppPreferenceSource {
  AppPreferenceSourceImpl(
      {required SharedPreferences sharedPreferences,
      required FlutterSecureStorage flutterSecureStorage}) {
    this.sharedPreferences = sharedPreferences;
    this.flutterSecureStorage = flutterSecureStorage;
  }
}
