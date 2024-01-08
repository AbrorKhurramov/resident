import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';

class BaseSurvey {
  late final SurveyType surveyType;

  getContainerBoxDecoration(isSelected) {
    if (surveyType == SurveyType.vote) {
      return BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.c6000 : Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: isSelected ? Colors.white : AppColor.c6000);
    } else {
      return BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.c6000 : AppColor.c8000,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: isSelected ? AppColor.c6000 : Colors.white);
    }
  }

  getTitleStyle(context, isSelected) {
    if (surveyType == SurveyType.vote) {
      return Theme.of(context).textTheme.headline3!.copyWith(
          color: isSelected ? AppColor.c4000 : Colors.white, fontSize: 14);
    } else {
      return Theme.of(context).textTheme.headline3!.copyWith(
          color: isSelected ? Colors.white : AppColor.c4000, fontSize: 14);
    }
  }

  getSubTitleStyle(context, isSelected) {
    if (surveyType == SurveyType.vote) {
      return Theme.of(context).textTheme.headline4!.copyWith(
          color: isSelected ? AppColor.c3000 : Colors.white.withOpacity(0.6),
          fontSize: 14);
    } else {
      return Theme.of(context).textTheme.headline4!.copyWith(
          color: isSelected ? Colors.white.withOpacity(0.6) : AppColor.c3000,
          fontSize: 13);
    }
  }
}
