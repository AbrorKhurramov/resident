import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';

mixin AppealRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<AppealType>>>
      getAppealTypes({
    required String apartmentId,
    required int page,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = {
      'apartment_id': apartmentId,
      'page': '$page',
      'size': '100',
    };

    return get(
      '/v1/citizen/reg-application-type',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<AppealType>(json))
        .mapRight((right) => right);
  }

  Future<Either<Exception, BasePaginationListResponse<AppealResponse>>>
      getHistoryAppeals({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = filterRequestParam.queryParameters();
    queryParameters['apartment_id'] = apartmentId;


    return get(
      '/v1/citizen/reg-application',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ).mapLeft((left) {
      return left;
    }).thenRight((json) {
      return parseJson<AppealResponse>(json);
    }).mapRight((right) {
      return right;
    });
  }
  Future<Either<Exception, BaseResponse<AppealResponse>>>
      getHistoryAppealsByID({
    required String appealId,
    required CancelToken cancelToken,
  }) async {


    return get(
      '/v1/citizen/reg-application/$appealId',
      cancelToken: cancelToken,
    ).mapLeft((left) {
      return left;
    }).thenRight((json) {
      return parseJson<AppealResponse>(json);
    }).mapRight((right) {
      return right;
    });
  }

  Future<Either<Exception, BaseResponse<AppealResponse>>>
      createAppeal({
    required AppealRequest appealRequest,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> map = baseAPI.options.headers;
    map['Content-Type'] = 'application/json';

    return post(
      '/v1/citizen/reg-application',
      data: appealRequest,
      headers: map,
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<AppealResponse>(json))
        .mapRight((right) => right);
  }
}
