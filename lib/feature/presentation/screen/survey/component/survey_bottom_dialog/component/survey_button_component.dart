import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/presentation/component/app_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SurveyButtonComponent extends StatefulWidget {
  final bool isAnswered;
  final bool loading;
  final Survey survey;
  final int activeQuestionPos;
  final VoidCallback onNextClick;
  final VoidCallback onPreviousClick;
  final VoidCallback onSubmitClick;

  const SurveyButtonComponent({
    Key? key,
    required this.isAnswered,
    required this.loading,
    required this.survey,
    required this.activeQuestionPos,
    required this.onNextClick,
    required this.onPreviousClick,
    required this.onSubmitClick,
  }) : super(key: key);

  @override
  State<SurveyButtonComponent> createState() => _SurveyButtonComponentState();
}

class _SurveyButtonComponentState extends State<SurveyButtonComponent> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _initButtonLogic(),
    );
  }

  _initButtonLogic() {
    int quizLength = widget.survey.questions.length;
    List<Widget> list = [];

    if (quizLength == 0) {
      list.add(AppDimension.defaultSize);
    } else if (quizLength == 1) {
      list.add(_initSubmitButton());
    } else if (quizLength > 1 && widget.activeQuestionPos < quizLength - 1) {
      list.add(_initPreviousButton());
      list.add(AppDimension.horizontalSize_8);
      list.add(_initNextButton());
    } else {
      list.add(_initPreviousButton());
      list.add(AppDimension.horizontalSize_8);
      list.add(_initSubmitButton());
    }

    return list;
  }

  Widget _initPreviousButton() {
    return Expanded(
      child: AppButton(
          isLoading: false,
          isSmallSize: false,
          primaryColor: AppColor.c60000,
          onPrimaryColor: Colors.black,
          onClick: widget.onPreviousClick,
          label: widget.activeQuestionPos!=0? _appLocalization.back:_appLocalization.close,
          labelColor: Colors.black),
    );
  }

  Widget _initNextButton() {
    var surveyType = widget.survey.surveyType;

    return Expanded(
      child: AppButton(
          isLoading: false,
          isSmallSize: false,
          primaryColor:
              surveyType == SurveyType.vote ? Colors.white : AppColor.c6000,
          onPrimaryColor:
              surveyType == SurveyType.survey ? Colors.white : AppColor.c6000,
          onClick: widget.onNextClick,
          label: _appLocalization.next,
          labelColor:
              surveyType == SurveyType.vote ? AppColor.c6000 : Colors.white),
    );
  }

  Widget _initSubmitButton() {
    return Expanded(
      child: AppButton(
          isLoading: widget.loading,
          isSmallSize: true,
          primaryColor: _getStyleButtonColor(),
          onPrimaryColor: _getStyleButtonColor(),
          onClick: widget.isAnswered ? null : widget.onSubmitClick,
          label: widget.isAnswered
              ? _appLocalization.you_have_already_voted
              : _appLocalization.vote,
          labelColor: _getStyleButtonLabelColor()),
    );
  }

  _getStyleButtonColor() {
    var surveyType = widget.survey.surveyType;
    if (surveyType == SurveyType.vote && !widget.isAnswered) {
      return Colors.white;
    } else if (surveyType == SurveyType.survey && !widget.isAnswered) {
      return AppColor.c6000;
    } else {
      return surveyType == SurveyType.vote
          ? AppColor.c300000.withOpacity(0.3)
          : AppColor.c60000;
    }
  }

  _getStyleButtonLabelColor() {
    var surveyType = widget.survey.surveyType;
    if (surveyType == SurveyType.vote && !widget.isAnswered) {
     if(widget.survey.questions[widget.activeQuestionPos].variants!.isNotEmpty) {
       return AppColor.c6000;
     }
     else {
       return AppColor.c3000;
     }
    } else if (surveyType == SurveyType.survey && !widget.isAnswered) {
      return Colors.white;
    } else {
      return surveyType == SurveyType.vote ? AppColor.c60000 : AppColor.c3000;
    }
  }
}
