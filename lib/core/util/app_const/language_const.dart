class LanguageConst {
  static const String english = 'en';
  static const String russian = 'ru';
  static const String uzbek = 'uz';

  static String getLanguageCode(String sysLangCode) {
    if (sysLangCode == english ||
        sysLangCode == russian ||
        sysLangCode == uzbek) {
      return sysLangCode;
    } else {
      return english;
    }
  }
}
