import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/survey_cubit/survey_state.dart';
import 'package:either_dart/either.dart';

class SurveyCubit extends RepositoryCubit<SurveyState> {
  final GetSurveyByIdUseCase getSurveyByIdUseCase;
  final SetSurveyUseCase setSurveyUseCase;


  SurveyCubit({
    required this.getSurveyByIdUseCase,
    required this.setSurveyUseCase,
    required SurveyState surveyState,
  }) : super(surveyState);

  void getSurveyById(String surveyId) {
    emit(state.copyWith(stateStatus: StateStatus.loading));
    getSurveyByIdUseCase
        .call(GetSurveyByIdUseCaseParams(surveyId, cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }

  SurveyList getCurrentSurvey() => state.currentSurvey;

  Survey getSurveyResponse() {
    return state.response!.data!;
  }

  void changeQuestion(List<Question> questionList) {
    BaseResponse<Survey>? newResponse = state.response!.copyWith(
        data: state.response!.data!.copyWith(questions: questionList));

    emit(state.copyWith(response: newResponse));
  }

  void setAnswer() {
    emit(state.copyWith(answerSurveyStatus: StateStatus.loading));

    List<ResultRequest> resultRequests = [];

    for (Question question in state.response!.data!.questions) {
      List<AnswerRequest> answerRequest = [];
      for (String id in question.answersId!) {
        answerRequest.add(AnswerRequest(id: id));
      }
      ResultRequest item =
          ResultRequest(id: question.id, answers: answerRequest);
      resultRequests.add(item);
    }

    setSurveyUseCase
        .call(SetSurveyUseCaseParams(
            state.currentSurvey.id, resultRequests, cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                answerSurveyStatus: StateStatus.failure, answerFailure: left)),
            (right) =>
                emit(state.copyWith(answerSurveyStatus: StateStatus.success)));
  }
}
