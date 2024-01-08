import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class GetSurveyByIdUseCase
    extends UseCase<BaseResponse<Survey>, GetSurveyByIdUseCaseParams> {
  final SurveyRepository surveyRepository;

  GetSurveyByIdUseCase(this.surveyRepository);

  @override
  Future<Either<Failure, BaseResponse<Survey>>> call(
      GetSurveyByIdUseCaseParams params) {
    return surveyRepository
        .getSurveyById(
            surveyId: params.surveyId, cancelToken: params.cancelToken)
        .fold((left) {
      return Left(left);
    }, (right) {
      _sortSurveyResponse(right.data!);
      return Right(right);
    });
  }

  _sortSurveyResponse(Survey survey) {
    for (int i = 0; i < survey.questions.length; i++) {
      innerLop:
      for (int j = i + 1; j < survey.results.length; j++) {
        if (survey.questions[i].id == survey.results[j].questionId) {
          Result swap = survey.results[i];
          survey.results[i] = survey.results[j];
          survey.results[j] = swap;
          break innerLop;
        }
      }
    }

    for (Question question in survey.questions) {
      innerLoop:
      for (Answer answers in survey.answers) {
        if (question.id == answers.questionId) {
          question = question.copyWith(answersId: [
            ...answers.answers.map((answerVariant) => answerVariant.variantId)
          ]);
          break innerLoop;
        }
      }
    }
  }
}

class GetSurveyByIdUseCaseParams extends Equatable {
  final String surveyId;
  final CancelToken cancelToken;

  const GetSurveyByIdUseCaseParams(this.surveyId, this.cancelToken);

  @override
  List<Object?> get props => [surveyId, cancelToken];
}
