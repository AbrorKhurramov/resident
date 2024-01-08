import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/base/base_select_survey.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/base/base_survey.dart';

class SurveySingleSelect extends StatefulWidget
    with BaseSurvey, BaseSelectSurvey {
  final Survey survey;
  final int activePosition;

  SurveySingleSelect(
      {Key? key, required this.survey, required this.activePosition})
      : super(key: key) {
    surveyType = survey.surveyType;
  }

  @override
  State<StatefulWidget> createState() {
    return SurveySingleSelectState();
  }
}

class SurveySingleSelectState extends State<SurveySingleSelect> {
  late int? _value;
  late List<String> answersId = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  _init(Question question) {
    _value = null;
    if (question.answersId != null) {
      outerLoop:
      for (int i = 0; i < question.answersId!.length; i++) {
        for (int j = 0; j < question.variants!.length; j++) {
          if (question.answersId![i] == question.variants![j].id) {
            _value = j;
            _addAnswerId(question.variants![_value as int].id);
            break outerLoop;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _init(widget.survey.questions[widget.activePosition]);
    return widget.survey.questions[widget.activePosition].variants!.isEmpty
        ? Container()
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                widget.survey.questions[widget.activePosition].variants!.length,
            itemBuilder: (context, index) {
              return _initRadioItem(
                  widget.survey.questions[widget.activePosition], index);
            },
          );
  }

  _initRadioItem(Question question, index) {
    bool isSelected = _value == index;
    return Theme(
        data: widget.getThemeData(context, isSelected),
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          decoration: widget.getContainerBoxDecoration(_value == index),
          child: RadioListTile<int>(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            dense: true,
            value: index,
            groupValue: _value,
            activeColor: widget.getRadioActiveColor(widget, isSelected),
            controlAffinity: ListTileControlAffinity.trailing,
            onChanged: (pos) {
              _onRadioClick(question, pos);
            },
            title: Text(
              question.variants![index].name.translate(
                      context.read<LanguageCubit>().languageCode()) ??
                  '',
              style: widget.getTitleStyle(context, isSelected),
            ),
            subtitle: Text(
                question.variants?[index].description.translate(
                        context.read<LanguageCubit>().languageCode()) ??
                    '',
                style: widget.getSubTitleStyle(context, isSelected)),
          ),
        ));
  }

  _onRadioClick(Question question, pos) {
    Survey? survey = context.read<SurveyCubit>().state.response!.data;

    if (survey != null) {
      _addAnswerId(question.variants![pos].id);
      changeQuestion(survey);
    }
  }

  changeQuestion(Survey survey) {
    List<Question> newQuestionList = [...survey.questions];
    newQuestionList[widget.activePosition] =
        survey.questions[widget.activePosition].copyWith(answersId: answersId);

    context.read<SurveyCubit>().changeQuestion(newQuestionList);
  }

  _addAnswerId(String id) {
    List<String> newAnswerId = [];
    newAnswerId.add(id);
    answersId = newAnswerId;
  }
}
