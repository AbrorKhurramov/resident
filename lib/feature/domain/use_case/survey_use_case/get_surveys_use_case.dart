import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class GetSurveysUseCase extends UseCase<BasePaginationListResponse<SurveyList>,
    GetSurveysUseCaseParams> {
  final SurveyRepository surveyRepository;

  GetSurveysUseCase(this.surveyRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<SurveyList>>> call(
      GetSurveysUseCaseParams params) {
    return surveyRepository.getSurveys(
        filterRequestParam: params.filterRequestParam,
        cancelToken: params.cancelToken);
  }
}

class GetSurveysUseCaseParams extends Equatable {
  final FilterRequestParam filterRequestParam;
  final CancelToken cancelToken;

  const GetSurveysUseCaseParams(this.filterRequestParam, this.cancelToken);

  @override
  List<Object?> get props => [filterRequestParam, cancelToken];
}
