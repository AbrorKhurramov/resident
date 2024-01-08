import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class SurveyStepComponent extends StatelessWidget {
  final Survey survey;
  final int totalCount;
  final int chosenRange;
  final Color stepColor;

  const SurveyStepComponent(
      {Key? key,
        required this.survey,
      required this.totalCount,
      required this.chosenRange,
      required this.stepColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _initDividerList(context)),
    );
  }

  _initDividerList(context) {
    List<Widget> list = [];

    for (int i = 0; i < totalCount; i++) {
      list.add(Expanded(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 4,
          minHeight: 4,
          maxWidth: 40,
        ),
        child: Container(
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
              color: i <= chosenRange
                  ? stepColor
                  :survey.surveyType == SurveyType.vote
                      ? AppColor.c60000.withOpacity(0.2)
                      : AppColor.c3000.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      )));
    }

    return list;
  }
}
