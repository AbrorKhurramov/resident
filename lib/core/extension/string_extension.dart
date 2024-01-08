import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/core_package.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  DateTime parseDateTime() {

    if(length<13) {
      return DateFormat('yyyy-MM-dd').parse(this);
    }

    if (length < 18) {
      print("aaa");
      return DateFormat('yyyy-MM-dd HH:mm').parse(this);
    }

    return DateFormat('yyyy-MM-dd HH:mm:ss').parse(this);
  }
  DateTime parseFilterData(){
    return DateFormat('yyyy.MM.dd').parse(this);
  }

  String getMonthIndexLabel() {
    print(this);
    return length < 2 ? '0$this' : this;
  }

  String cardExpiryFormat() {
    return '${substring(0, 2)}/${substring(2, 4)}';
  }

  String cardNumberFormat() {
    return '${substring(0, 4)} ${substring(4, 8)} ${substring(8, 12)} ${substring(12, 16)}';
  }

  String getHourAndMinute() {
    String newString = this;
    if (contains(".")) {
      newString = substring(0, length - 1);
    }

    DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat
        .format(DateFormat('dd-MM-yyyy HH:mm').parse(newString));
  }

  String getDateWithHour(AppLocalizations appLocalization){
    DateTime dateTime = parseDateTime();

    return '${dateTime.getDay()} ${dateTime.getMonthLabel(appLocalization)} ${dateTime.year}, ${getHourAndMinute()}';
  }
  String getDateWithoutHour(AppLocalizations appLocalization){
    DateTime dateTime = parseDateTime();

    return '${dateTime.getDay()} ${dateTime.getMonthLabel(appLocalization)} ${dateTime.year}';
  }


  String getDifferenceDateString(AppLocalizations appLocalization) {
    String newString = this;
    if (contains(".")) {
      newString = substring(0, length - 1);
    }
    DateTime date = DateTime.parse(newString);
    Duration dur =  DateTime.now().difference(date);

   if(dur.inDays.floor()>0) {
     return "${dur.inDays.floor()} ${appLocalization.day}";
   }
   else if(dur.inHours.floor()>0) {
     return "${dur.inHours.floor()} ${appLocalization.hour}";
   }
   else if(dur.inMinutes.floor()>0){
   return "${dur.inMinutes.floor()} ${appLocalization.minute}";
   }
   else {
     return "${dur.inSeconds.floor()} ${appLocalization.second}";
   }
  }
}
