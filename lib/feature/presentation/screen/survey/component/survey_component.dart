import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/survey_item.dart';
import 'package:resident/feature/presentation/screen/survey/component/survey_bottom_dialog/survey_bottom_dialog.dart';

class SurveyComponent extends StatefulWidget {
   const SurveyComponent({Key? key,required this.surveyContext}) : super(key: key);
final BuildContext surveyContext;
  @override
  State<SurveyComponent> createState() => _SurveyComponentState();
}

class _SurveyComponentState extends State<SurveyComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SurveyListCubit, SurveyListState>(
        builder: (context, state) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, pos) {
          if (state.response!.currentPage + 1 != state.response!.totalPages &&
              pos == state.surveyList.length &&
              state.surveyList.isNotEmpty) {
            if (state.stateStatus != StateStatus.paginationLoading &&
                state.stateStatus != StateStatus.paginationFailure) {
              context.read<SurveyListCubit>().getPaginationSurveys();
            }

            if (state.stateStatus == StateStatus.paginationFailure) {
              return AppDimension.defaultSize;
            }

            return _initLoadingItem();
          }

          return _initSurveyItem(state.surveyList[pos]);
        },
        itemCount:
            state.response!.currentPage + 1 < state.response!.totalPages &&
                    state.surveyList.isNotEmpty
                ? state.surveyList.length + 1
                : state.surveyList.length,
      );
    });
  }

  _initSurveyItem(SurveyList survey) {
    return SurveyItem(
        survey: survey,
        onClick: () {
          _onItemClick(survey);
        });
  }

  _initLoadingItem() {
    return Container(
      height: 56,
      color: Colors.transparent,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _onItemClick(SurveyList survey) {
    showAppModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) {
            return SurveyCubit(
                getSurveyByIdUseCase: getIt<GetSurveyByIdUseCase>(),
                setSurveyUseCase: getIt<SetSurveyUseCase>(),
                surveyState: SurveyState(
                  stateStatus: StateStatus.initial,
                  answerSurveyStatus: StateStatus.initial,
                  currentSurvey: survey,
                ));
          },
          child: SurveyBottomDialog(surveyContext: widget.surveyContext),
        );
      },
    ).then((value) => () {
      print("Survey bottom dialog on survey component then $value");
          if (value != null && value == true) {
            context.read<SurveyListCubit>().getSurveys();
          }
        });
  }
}
