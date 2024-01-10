import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/base/base_select_survey.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/base/base_survey.dart';

class SurveyMultiSelect extends StatefulWidget
    with BaseSurvey, BaseSelectSurvey {
  final Survey survey;
  final int activePosition;

  SurveyMultiSelect(
      {Key? key, required this.survey, required this.activePosition})
      : super(key: key) {
    surveyType = survey.surveyType;
  }

  @override
  State<StatefulWidget> createState() {
    return SurveyMultiSelectState();
  }
}

class SurveyMultiSelectState extends State<SurveyMultiSelect> {
  late List<String> answersId = [];

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: widget
            .survey.questions[widget.activePosition].variants!.isNotEmpty,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              widget.survey.questions[widget.activePosition].variants!.length,
          itemBuilder: (context, index) {
            return _initCheckBoxItem(
                widget.survey.questions[widget.activePosition], index);
          },
        ));
  }

  _initCheckBoxItem(Question question, index) {
    bool isSelected = false;

    for (String answerId in question.answersId ?? []) {
      if (answerId == question.variants![index].id) {
        isSelected = true;
        break;
      }
    }

    return Theme(
        data: widget.getThemeData(context, isSelected),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: widget.getContainerBoxDecoration(isSelected),
          child: CheckboxListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              dense: true,
              value: isSelected,
              activeColor: widget.getRadioActiveColor(widget, isSelected),
              checkColor: widget.getCheckBoxActiveColor(widget, isSelected),
              controlAffinity: ListTileControlAffinity.trailing,
              onChanged: (isSelected) {
                _onCheckboxClick(question, index, isSelected!);
              },
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  question.variants![index].name.translate(context.read<LanguageCubit>().languageCode()) ?? '',
                  style: widget.getTitleStyle(context, isSelected),
                ),
              ),
              subtitle: Text(
                  question.variants![index].description.translate(context.read<LanguageCubit>().languageCode()) ?? '',
                  style: widget.getSubTitleStyle(context, isSelected))),
        ));
  }

  _onCheckboxClick(Question question, int index, bool isSelected) {
    Survey? survey = context.read<SurveyCubit>().state.response!.data;

    if (survey != null) {
      _addAnswerId(survey, question.variants![index].id, isSelected);
      _changeQuestion(survey);
    }
  }

  _addAnswerId(Survey survey, String id, bool isSelected) {
    List<String> newAnswerId =
        survey.questions[widget.activePosition].answersId != null
            ? [...survey.questions[widget.activePosition].answersId!]
            : [];
    if (isSelected) {
      newAnswerId.add(id);
    } else {
      newAnswerId.remove(id);
    }
    answersId = newAnswerId;
  }

  _changeQuestion(Survey survey) {
    List<Question> newQuestionList = [...survey.questions];
    newQuestionList[widget.activePosition] =
        survey.questions[widget.activePosition].copyWith(answersId: answersId);

    context.read<SurveyCubit>().changeQuestion(newQuestionList);
  }
}
