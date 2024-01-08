

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';

import '../../../../../../../core/enum/survey_type.dart';
import '../../../../../../../core/util/app_dimension.dart';




class EmptyQuestionSurvey extends StatelessWidget {
  const EmptyQuestionSurvey({Key? key,required this.label,required this.surveyType}) : super(key: key);
  final String label;
  final SurveyType surveyType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDimension.verticalSize_64,
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:surveyType==SurveyType.vote? Colors.white:AppColor.c6000.withOpacity(0.1),
          ),
          width: 104,
          height: 104,
          child: ClipOval(
            child: SvgPicture.asset('assets/icons/info.svg'),
          ),
        ),
        AppDimension.verticalSize_24,
        Text(
         label,
          style: Theme.of(context).textTheme.headline2!.copyWith(color:surveyType==SurveyType.vote? Colors.white:AppColor.c6000, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
