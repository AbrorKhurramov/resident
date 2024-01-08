import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

mixin SurveyRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<SurveyList>>> getSurveys(
      {required FilterRequestParam filterRequestParam,
      required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<SurveyList>> response =
        await appRemoteSource.getSurveys(
      filterRequestParam: filterRequestParam,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<SurveyList>>(response);
  }

  Future<Either<Failure, BaseResponse<Survey>>> getSurveyById({
    required String surveyId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<Survey>> response = await appRemoteSource
        .getSurveyById(surveyId: surveyId, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<Survey>>(response);
  }

  Future<Either<Failure, BaseResponse<Survey>>> setSurveyResult({
    required String surveyId,
    required List<ResultRequest> results,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<Survey>> response =
        await appRemoteSource.setSurveyResult(
            surveyId: surveyId, results: results, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<Survey>>(response);
  }
}
