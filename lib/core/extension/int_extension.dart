import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';

extension IntExtension on int {
  CommunalType getCommunalType() {
    switch (this) {
      case 1:
        return CommunalType.electricity;
      case 2:
        return CommunalType.hotWater;
      case 3:
        return CommunalType.coldWater;
      case 4:
        return CommunalType.gas;
        case 5:
        return CommunalType.other;
      default:
        return CommunalType.other;
    }
  }

  String currencyFormat() {
    return NumberFormat("#,##0.00", "en_US").format(this / 100);
  }

}
