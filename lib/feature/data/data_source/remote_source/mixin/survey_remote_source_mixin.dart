import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

mixin SurveyRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<SurveyList>>> getSurveys({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryP = filterRequestParam.queryParameters();
    queryP["is_expired"]=0;
    return get(
      '/v1/citizen/survey/basic-new-list',
      queryParameters: queryP,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<SurveyList>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<Survey>>> getSurveyById({
    required String surveyId,
    required CancelToken cancelToken,
  }) async {
    return get(
      '/v1/citizen/survey/$surveyId',
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Survey>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<Survey>>> setSurveyResult({
    required String surveyId,
    required List<ResultRequest> results,
    required CancelToken cancelToken,
  }) async {
    print("Set survey");
    return post(
      '/v1/citizen/answer/$surveyId',
      data: results,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Survey>(json)).mapRight((right) => right);
  }
}
