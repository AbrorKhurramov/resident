import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class SurveyRepository {
  Future<Either<Failure, BasePaginationListResponse<SurveyList>>> getSurveys({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<Survey>>> getSurveyById({
    required String surveyId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<Survey>>> setSurveyResult({
    required String surveyId,
    required List<ResultRequest> results,
    required CancelToken cancelToken,
  });
}
