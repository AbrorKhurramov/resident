import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class SurveyListState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<SurveyList>? response;
  late final List<SurveyList> voteList;
  late final List<SurveyList> surveyList;
  final Failure? loadingFailure;
  final Failure? loadingPaginationFailure;

  SurveyListState({
    required this.stateStatus,
    this.response,
    List<SurveyList>? voteList,
    List<SurveyList>? surveyList,
    this.loadingFailure,
    this.loadingPaginationFailure,
  }) {
    this.voteList = voteList ?? [];
    this.surveyList = surveyList ?? [];
  }

  SurveyListState copyWith({
    StateStatus? stateStatus,
    BasePaginationListResponse<SurveyList>? response,
    List<SurveyList>? voteList,
    List<SurveyList>? surveyList,
    Failure? loadingFailure,
    Failure? loadingPaginationFailure,
  }) {
    return SurveyListState(
      stateStatus: stateStatus ?? this.stateStatus,
      response: response ?? this.response,
      voteList: voteList ?? this.voteList,
      surveyList: surveyList ?? this.surveyList,
      loadingFailure: loadingFailure,
      loadingPaginationFailure: loadingPaginationFailure,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        voteList,
        surveyList,
        loadingFailure,
        loadingPaginationFailure,
      ];
}
