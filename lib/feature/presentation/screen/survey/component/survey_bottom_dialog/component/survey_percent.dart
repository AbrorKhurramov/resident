import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/base/base_select_survey.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/base/base_survey.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyPercent extends StatefulWidget with BaseSurvey, BaseSelectSurvey {
  final Survey survey;
  final int activePosition;

  SurveyPercent({Key? key, required this.survey, required this.activePosition})
      : super(key: key) {
    surveyType = survey.surveyType;
  }

  @override
  State<SurveyPercent> createState() => _SurveyPercentState();
}

class _SurveyPercentState extends State<SurveyPercent> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _initItem(widget.survey, index);
      },
      itemCount:
          widget.survey.questions[widget.activePosition].variants!.length,
    );
  }

  _initItem(Survey surveyResponse, index) {
    bool isSelected = false;
    ResultVariant? resultVariant;

    for (String answerId
        in surveyResponse.questions[widget.activePosition].answersId ?? []) {
      if (answerId ==
          surveyResponse.questions[widget.activePosition].variants![index].id) {
        isSelected = true;
        break;
      }
    }

    for (ResultVariant res
        in surveyResponse.results[widget.activePosition].resultVariants) {
      if (res.id ==
          surveyResponse.questions[widget.activePosition].variants![index].id) {
        resultVariant = res;
        break;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: widget.getContainerBoxDecoration(isSelected),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              child: Text(
                '${_appLocalization.your_voice.toUpperCase()}:',
                style: _getUserVoteStyle(context, isSelected),
              ),
              visible: isSelected),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                        '${surveyResponse.questions[widget.activePosition].variants![index].name.translate(context.read<LanguageCubit>().languageCode())}',
                        style: widget.getTitleStyle(context, isSelected)),
                    AppDimension.verticalSize_4,
                    Text(surveyResponse.questions[widget.activePosition].variants![index].description.translate(context.read<LanguageCubit>().languageCode())!=null?
                        '${surveyResponse.questions[widget.activePosition].variants![index].description.translate(context.read<LanguageCubit>().languageCode())}':"",
                        style: widget.getSubTitleStyle(context, isSelected))
                  ],
                ),
              ),
              SizedBox(width: 8),
              Text(
                '${resultVariant!.percent.toStringAsFixed(2)}%',
                style: _getPercentCountStyle(context, isSelected),
              ),
            ],
          ),
          SizedBox(height: 16),
          LinearPercentIndicator(
            lineHeight: 16,
            percent:
                double.parse(resultVariant.percent.toStringAsFixed(2)) / 100,
            progressColor: _getPercentProgressColor(isSelected),
            backgroundColor: _getPercentBackgroundColor(isSelected),
          )
        ],
      ),
    );
  }

  _getUserVoteStyle(context, isSelected) {
    if ((widget.surveyType == SurveyType.vote && isSelected) ||
        (widget.surveyType == SurveyType.vote && !isSelected)) {
      return Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(color: AppColor.c4000, fontSize: 14);
    } else if ((widget.surveyType == SurveyType.vote && !isSelected) ||
        (widget.surveyType == SurveyType.survey && isSelected)) {
      return Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(color: Colors.white, fontSize: 14);
    }
  }

  _getPercentCountStyle(context, isSelected) {
    if ((widget.surveyType == SurveyType.vote && isSelected) ||
        (widget.surveyType == SurveyType.survey && !isSelected)) {
      return Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(color: AppColor.c4000, fontSize: 16);
    } else if ((widget.surveyType == SurveyType.vote && !isSelected) ||
        (widget.surveyType == SurveyType.survey && isSelected)) {
      return Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(color: Colors.white, fontSize: 16);
    }
  }

  _getPercentProgressColor(isSelected) {
    if ((widget.surveyType == SurveyType.vote && isSelected) ||
        (widget.surveyType == SurveyType.survey && !isSelected)) {
      return AppColor.c6000;
    } else if ((widget.surveyType == SurveyType.vote && !isSelected) ||
        (widget.surveyType == SurveyType.survey && isSelected)) {
      return Colors.white;
    }
  }

  _getPercentBackgroundColor(isSelected) {
    if ((widget.surveyType == SurveyType.vote && isSelected) ||
        (widget.surveyType == SurveyType.survey && !isSelected)) {
      return Colors.grey.withOpacity(0.4);
    } else if ((widget.surveyType == SurveyType.vote && !isSelected) ||
        (widget.surveyType == SurveyType.survey && isSelected)) {
      return Colors.white.withOpacity(0.4);
    }
  }
}
