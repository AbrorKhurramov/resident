import 'package:shared_preferences/shared_preferences.dart';

mixin LanguagePreferenceSourceMixin {
  static const String languageCode = "LANGUAGE_CODE";

  late final SharedPreferences sharedPreferences;

  Future<void> setLanguageCode(String param) async {
    sharedPreferences.setString(languageCode, param);
  }

  Future<String?> getLanguageCode() async {
    return sharedPreferences.getString(languageCode);
  }
}
