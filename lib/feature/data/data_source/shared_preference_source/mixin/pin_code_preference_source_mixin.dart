import 'package:shared_preferences/shared_preferences.dart';

mixin PinCodePreferenceSourceMixin {
  static const String pinCode = "PIN_CODE";

  late final SharedPreferences sharedPreferences;

  Future<void> setPinCode(String params) async {
    sharedPreferences.setString(pinCode, params);
  }

  Future<String?> getPinCode() async {
    return sharedPreferences.getString(pinCode);
  }

  Future<void> removePinCode() async {
    sharedPreferences.remove(pinCode);
  }
}
