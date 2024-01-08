import 'package:resident/app_package/core_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension CommunalTypeExtension on CommunalType {
  String getIconPath() {
    switch (this) {

      case CommunalType.coldWater:
        return 'assets/icons/cold_water.svg';
      case CommunalType.hotWater:
        return 'assets/icons/hot_water.svg';
      case CommunalType.electricity:
        return 'assets/icons/light.svg';
      case CommunalType.gas:
        return 'assets/icons/gas.svg';
        case CommunalType.other:
        return 'assets/icons/other.svg';
      default:
        return 'assets/icons/hot_water.sv';
    }
  }

  String getLabel(AppLocalizations _appLocalization) {
    switch (this) {
      case CommunalType.coldWater:
        return _appLocalization.cold_water;
      case CommunalType.hotWater:
        return _appLocalization.hot_water;
      case CommunalType.electricity:
        return _appLocalization.electricity;
        case CommunalType.gas:
        return _appLocalization.gas;
        case CommunalType.other:
        return "Коммунальные услуги";
      default:
        return _appLocalization.electricity;
    }
  }



  String getDescription(AppLocalizations _appLocalization) {
    if (this == CommunalType.electricity) {
      return _appLocalization.electricity_description;
    }
    if(this == CommunalType.other){
      return "К услугам жилого комплекса не относится";
    }
    return '';
  }
}
