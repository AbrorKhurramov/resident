import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/survey_list_cubit/survey_list_state.dart';
import 'package:either_dart/either.dart';

class SurveyListCubit extends RepositoryCubit<SurveyListState> {
  final GetSurveysUseCase getSurveysUseCase;

  SurveyListCubit({required this.getSurveysUseCase})
      : super(SurveyListState(stateStatus: StateStatus.initial));

  void getSurveys() async {
    print("GETSURVEYS");
    emit(state.copyWith(stateStatus: StateStatus.loading));
    getSurveysUseCase
        .call(GetSurveysUseCaseParams(FilterRequestParam(page: 0), cancelToken))
        .fold((left) {
      return emit(state.copyWith(
          stateStatus: StateStatus.loading, loadingFailure: left));
    }, (right) {
      List<List<SurveyList>> sortedList = _sortSurvey(right.data);
      return emit(state.copyWith(
          stateStatus: StateStatus.success,
          response: right,
          voteList: sortedList[0],
          surveyList: [...sortedList[1]]));
    });
  }

  void getPaginationSurveys() async {
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));
    getSurveysUseCase
        .call(GetSurveysUseCaseParams(
            FilterRequestParam(page: state.response!.currentPage + 1),
            cancelToken))
        .fold((left) {
      return emit(state.copyWith(
          stateStatus: StateStatus.paginationFailure,
          loadingPaginationFailure: left));
    }, (right) {
      List<List<SurveyList>> sortedList = _sortSurvey(right.data);
      return emit(state.copyWith(
          stateStatus: StateStatus.success,
          response: right,
          voteList: [...state.voteList, ...sortedList[0]],
          surveyList: [...state.surveyList, ...sortedList[1]]));
    });
  }

  List<List<SurveyList>> _sortSurvey(List<SurveyList> allSurvey) {
    List<List<SurveyList>> sortedList = [];
    List<SurveyList> voteList = [];
    List<SurveyList> surveyList = [];

    for (SurveyList survey in allSurvey) {
      if (!survey.isExpired) {
        if (survey.surveyType == SurveyType.vote) {
          voteList.add(survey);
        } else {
          surveyList.add(survey);
        }
      }
    }

    sortedList.add(voteList);
    sortedList.add(surveyList);

    return sortedList;
  }
}
