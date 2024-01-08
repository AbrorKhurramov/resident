import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/empty_survey.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/survey_button_component.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/survey_multi_select.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/survey_percent.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/survey_single_select.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/component/survey_step_component.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_success_dialog/survey_success_dialog.dart';
import 'package:resident/main.dart';


class SurveyBottomDialog extends StatefulWidget {
   SurveyBottomDialog({
    Key? key,required this.surveyContext
  }) : super(key: key);
BuildContext surveyContext;
  @override
  State<StatefulWidget> createState() {
    return _SurveyBottomDialogState();
  }
}

class _SurveyBottomDialogState extends State<SurveyBottomDialog> {
  late AppLocalizations _appLocalization;
  late int activeQuestionPos = 0;
  late PageController _controller;
 // bool isAnswered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = PageController(
        initialPage: activeQuestionPos, keepPage: true, viewportFraction: 1);
    context
        .read<SurveyCubit>()
        .getSurveyById(context.read<SurveyCubit>().getCurrentSurvey().id);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _initActiveQuestionPosition() {
    Survey survey = context.read<SurveyCubit>().state.response!.data!;
    if (context.read<SurveyCubit>().getCurrentSurvey().isAnswered) return 0;
    for (int i = 0; i < survey.questions.length; i++) {
      List<String>? answersId = survey.questions[i].answersId;
      if (answersId == null || answersId.isEmpty) {
        return i;
      }
    }
    return survey.questions.length - 1;
  }

  void _openSuccessBottomDialog() {
    showAppModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) {
        return SurveySuccessDialog(true,surveyContext: widget.surveyContext);
      },
    ).then((value) => () {
      setState(() {
        print("Success dialog then $value");
        if (value != null && value == true) {
        //  isAnswered = true;
         context.read<SurveyCubit>().getSurveyById(
              context.read<SurveyCubit>().getCurrentSurvey().id);
        }
      });
      });
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async {

   //     Navigator.pop(context,isAnswered);
      return true;
      },
      child: Scaffold(
        backgroundColor:
            context.read<SurveyCubit>().getCurrentSurvey().surveyType ==
                    SurveyType.vote
                ? AppColor.c6000
                : Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: SizedBox(
                width: AppConfig.screenWidth(context),
                height: AppConfig.screenHeight(context) * 0.9,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                          'assets/icons/modal_bottom_top_line.svg'),
                      AppDimension.verticalSize_16,
                      BlocConsumer<SurveyCubit, SurveyState>(
                        listener: (context, state) {
                          if (state.stateStatus == StateStatus.failure) {
                            MyApp.failureHandling(context, state.failure!);
                          } else if (state.answerSurveyStatus ==
                              StateStatus.failure) {
                            MyApp.failureHandling(
                                context, state.answerFailure!);
                          } else if (state.answerSurveyStatus ==
                              StateStatus.success) {
                            _openSuccessBottomDialog();
                          }
                        },
                        builder: (context, state) {
                          if (state.stateStatus == StateStatus.failure) {
                            return Expanded(
                              child: Center(
                                child: Text(state.failure.toString()),
                              ),
                            );
                          }

                        if (state.stateStatus == StateStatus.loading) {
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (state.stateStatus == StateStatus.success &&
                            state.response!.data != null) {
                          _initActiveQuestionPosition();
                          return Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onHorizontalDragEnd: (dragEndDetails) {
                                      if (dragEndDetails.primaryVelocity! <
                                          0) {
                                        _onNextClick(context
                                            .read<SurveyCubit>()
                                            .state
                                            .response!
                                            .data!);
                                      } else if (dragEndDetails
                                              .primaryVelocity! >
                                          0) {
                                        _onPreviousClick();
                                      }
                                    },
                                    child:state
                                        .response!.data!.questions.isNotEmpty? PageView.builder(
                                      controller: _controller,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, pos) {
                                        return _initPageItem(
                                            state.response!.data!, pos);
                                      },
                                      itemCount: state
                                          .response!.data!.questions.length,
                                    ):EmptyQuestionSurvey(label:  _appLocalization.survey_under_development.toUpperCase(),surveyType: context.read<SurveyCubit>().getCurrentSurvey().surveyType),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppDimension.verticalSize_24,
                                    Visibility(
                                      visible: state.response!.data!.questions
                                              .length >
                                          1,
                                      child: SurveyStepComponent(
                                        survey: state.response!.data!,
                                        totalCount: state
                                            .response!.data!.questions.length,
                                        chosenRange: activeQuestionPos,
                                        stepColor: state.response!.data!
                                                    .surveyType ==
                                                SurveyType.vote
                                            ? Colors.white
                                            : AppColor.c6000,
                                      ),
                                    ),
                                    AppDimension.verticalSize_24,
                                    Text(
                                      _appLocalization.you_must_vote_before
                                          .capitalize(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!
                                          .copyWith(
                                              color: state.response!.data!
                                                          .surveyType ==
                                                      SurveyType.vote
                                                  ? Colors.white
                                                      .withOpacity(0.6)
                                                  : AppColor.c3000,
                                              fontSize: 11),
                                    ),
                                    AppDimension.verticalSize_4,
                                    Text(
                                        state.response!.data!.expiryDate.getDateWithHour(_appLocalization),
                                       // state.response!.data!.expiryDate,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2!
                                            .copyWith(
                                                color: state.response!.data!
                                                            .surveyType ==
                                                        SurveyType.vote
                                                    ? Colors.white
                                                    : AppColor.c4000,
                                                fontSize: 12)),
                                    AppDimension.verticalSize_16,
                                    Visibility(
                                      visible: state
                                          .response!.data!.questions.isNotEmpty&&state
                                          .response!.data!.results.isNotEmpty,
                                      child: SurveyButtonComponent(
                                          isAnswered:
                                              state.currentSurvey.isAnswered,
                                          loading: state.answerSurveyStatus ==
                                              StateStatus.loading,
                                          survey: state.response!.data!,
                                          activeQuestionPos: activeQuestionPos,
                                          onNextClick: () {
                                            _onNextClick(state.response!.data!);
                                          },
                                          onPreviousClick: _onPreviousClick,
                                          onSubmitClick: () {
                                            if(state.response!.data!.questions[activeQuestionPos].variants!.isNotEmpty) {
                                              _onSubmitClick(state.response!.data!);
                                            }
                                          }),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }

                        return AppDimension.defaultSize;
                      },
                    )
                  ],
                ),
              ))),
    ));
  }

  

  _initPageItem(Survey survey, int pos) {
    print( survey.questions[activeQuestionPos].description.translate(
        context.read<LanguageCubit>().languageCode()));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Text(
            '${survey.questions[activeQuestionPos].question.translate(context.read<LanguageCubit>().languageCode())}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                color: survey.surveyType == SurveyType.vote
                    ? Colors.white
                    : AppColor.c4000,
                fontSize: 17),
          ),
          AppDimension.verticalSize_8,
          Text(
              survey.questions[activeQuestionPos].description.translate(
                      context.read<LanguageCubit>().languageCode()) ??
                  '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: survey.surveyType == SurveyType.vote
                      ? Colors.white.withOpacity(0.6)
                      : AppColor.c3000,
                  fontSize: 14,
                  height: 1.3)),
          AppDimension.verticalSize_16,
          _initSurveyComponent(survey),
         if(survey.results.length>activeQuestionPos) Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Center(
                child: Text(
              '${_appLocalization.voted.capitalize()} ${_appLocalization.residents}: ${survey.results[activeQuestionPos].totalUsers} ',
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: survey.surveyType == SurveyType.vote
                      ? Colors.white.withOpacity(0.6)
                      : AppColor.c3000,
                  fontSize: 11),
            )),
          ),
        ],
      ),
    );
  }

  _initSurveyComponent(Survey survey) {
    List<AnswerVariant> answerVariants =
        _getAnswerByQuestionId(survey, survey.questions[activeQuestionPos].id);
    print(survey.results.isNotEmpty);
    if (survey.results.isNotEmpty && answerVariants.isNotEmpty) {
      return SurveyPercent(survey: survey, activePosition: activeQuestionPos);
    } else if (survey.questions.isNotEmpty && survey.questions[activeQuestionPos].variants!.isNotEmpty &&
        survey.questions[activeQuestionPos].type.getQuestionType() ==
            QuestionType.singleType) {
      return SurveySingleSelect(
          survey: survey, activePosition: activeQuestionPos);
    } else if(survey.questions[activeQuestionPos].variants!.isNotEmpty) {
      return SurveyMultiSelect(
          survey: survey, activePosition: activeQuestionPos);
    }
    else {
      return EmptyQuestionSurvey(label:  _appLocalization.survey_under_development.toUpperCase(),surveyType: context.read<SurveyCubit>().getCurrentSurvey().surveyType);
    }
  }

  List<AnswerVariant> _getAnswerByQuestionId(Survey survey, String questionId) {
    List<AnswerVariant> list = [];
    for (Answer answer in survey.answers) {
      if (answer.questionId == questionId) return answer.answers;
    }

    return list;
  }

  void _onNextClick(Survey survey) {

    //print(survey.results.toString());
    print(survey.answers.toString());
   //print(context.read<SurveyCubit>().getCurrentSurvey().isAnswered);

     if (_isCompleted(survey) ||
        context.read<SurveyCubit>().getCurrentSurvey().isAnswered) {
      if (activeQuestionPos < survey.questions.length - 1) {
        _controller.jumpToPage(activeQuestionPos++);
        _controller.animateToPage(activeQuestionPos,
            curve: Curves.decelerate, duration: Duration(milliseconds: 300));

        setState(() {});
      }
    } else {
      showErrorFlushBar(
          context, _appLocalization.choose_your_answer.capitalize());
    }
  }

  void _onPreviousClick() {
    if (activeQuestionPos != 0) {
      _controller.jumpToPage(activeQuestionPos--);
      _controller.animateToPage(activeQuestionPos,
          curve: Curves.decelerate, duration: Duration(milliseconds: 300));
      setState(() {});
    }
    else {
      Navigator.of(context).pop();
    }
  }

  void _onSubmitClick(Survey survey) {
    if(_isCompleted(survey) ||
        context.read<SurveyCubit>().getCurrentSurvey().isAnswered) {
      context.read<SurveyCubit>().setAnswer();
    }
    else {
      showErrorFlushBar(
          context, _appLocalization.choose_your_answer.capitalize());
    }
  }

  bool _isCompleted(Survey survey) {
    List<String>? list = survey.questions[activeQuestionPos].answersId;
    return list != null && list.isNotEmpty;
  }
}
