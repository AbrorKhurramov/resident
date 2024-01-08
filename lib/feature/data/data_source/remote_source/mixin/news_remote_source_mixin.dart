import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

mixin NewsRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<Newness>>> getNews({
    required int page,
    int? size,
    required CancelToken cancelToken,
  }) async {
    dynamic queryParameters = {
      'page': '$page',
      'size': '10',
      'sort_by': 'createdDate',
      'sort_dir': 'desc',
    };

    return get(
      '/v1/citizen/news/',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Newness>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<Newness>>> getNewById({
    required int newId,
    required CancelToken cancelToken,
  }) async {
    return get(
      '/v1/citizen/news/$newId',
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Newness>(json)).mapRight((right) => right);
  }
}
