import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';

class BaseSelectSurvey {
  late final SurveyType surveyType;

  getThemeData(context, isSelected) {
    if (surveyType == SurveyType.vote) {
      return Theme.of(context).copyWith(
          unselectedWidgetColor: Colors.white,
          disabledColor: isSelected ? AppColor.c6000 : Colors.white);
    } else {
      return Theme.of(context).copyWith(
          unselectedWidgetColor: AppColor.c8000,
          disabledColor: isSelected ? AppColor.c6000 : Colors.white);
    }
  }

  getRadioActiveColor(context, isSelected) {
    if (surveyType == SurveyType.vote) {
      return isSelected ? AppColor.c6000 : Colors.white;
    } else {
      return isSelected ? Colors.white : AppColor.c6000;
    }
  }

  getCheckBoxActiveColor(context, isSelected) {
    if (surveyType == SurveyType.vote) {
      return isSelected ? Colors.white : AppColor.c6000;
    } else {
      return isSelected ? AppColor.c6000 : Colors.white;
    }
  }
}
