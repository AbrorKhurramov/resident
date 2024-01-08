import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class SurveyState extends Equatable {
  final StateStatus stateStatus;
  final StateStatus answerSurveyStatus;
  final BaseResponse<Survey>? response;
  final SurveyList currentSurvey;
  final Failure? failure;
  final Failure? answerFailure;

  const SurveyState(
      {required this.stateStatus,
      required this.answerSurveyStatus,
      required this.currentSurvey,
      this.response,
      this.failure,
      this.answerFailure});

  SurveyState copyWith({
    StateStatus? stateStatus,
    StateStatus? answerSurveyStatus,
    BaseResponse<Survey>? response,
    SurveyList? currentSurvey,
    Failure? failure,
    Failure? answerFailure,
  }) {
    return SurveyState(
      stateStatus: stateStatus ?? this.stateStatus,
      answerSurveyStatus: answerSurveyStatus ?? this.answerSurveyStatus,
      response: response ?? this.response,
      currentSurvey: currentSurvey ?? this.currentSurvey,
      failure: failure ?? this.failure,
      answerFailure: answerFailure ?? this.answerFailure,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        answerSurveyStatus,
        currentSurvey,
        response,
        failure,
        answerFailure,
      ];
}
