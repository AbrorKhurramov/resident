import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

mixin DocumentRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<Document>>> getDocuments({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    return get(
      '/v1/citizen/document/',
      queryParameters: filterRequestParam.queryParameters(),
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Document>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<Document>>> getDocumentById({
    required String documentId,
    required CancelToken cancelToken,
  }) async {
    return get(
      '/v1/citizen/document/$documentId',
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Document>(json)).mapRight((right) => right);
  }
}
