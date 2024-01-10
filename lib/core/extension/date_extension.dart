import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DateTimeExtension on DateTime {

  String formatDateTime(){
    String formattedDate = DateFormat('yyyy-MM-dd').format(this);
    return formattedDate;
  }

  String formatCalendarDateTime(){
    String formattedDate = DateFormat('dd.MM.yyyy').format(this);
    return formattedDate;
  }


  String getDay() {
    if (day < 10) {
      return '0$day';
    }
    return day.toString();
  }

  String getMinuteFormat() {
    if (minute < 10) {
      return '0$minute';
    }
    return minute.toString();
  }

  String getHourFormat() {
    if (hour < 10) {
      return '0$hour';
    }
    return hour.toString();
  }



  String getMonthLabel(AppLocalizations appLocalization) {
    switch (month) {
      case 1:
        return appLocalization.january;
      case 2:
        return appLocalization.february;
      case 3:
        return appLocalization.march;
      case 4:
        return appLocalization.april;
      case 5:
        return appLocalization.may;
      case 6:
        return appLocalization.june;
      case 7:
        return appLocalization.july;
      case 8:
        return appLocalization.august;
      case 9:
        return appLocalization.september;
      case 10:
        return appLocalization.october;
      case 11:
        return appLocalization.november;
      default:
        return appLocalization.december;
    }
  }
}
