import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

mixin ServicesRemoteSourceMixin implements BaseRequest {


  Future<Either<Exception, BasePaginationListResponse<MerchantResponse>>> getServicesList({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    return get(
      '/v1/citizen/merchant',
      queryParameters: filterRequestParam.queryParameters(),
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<MerchantResponse>(json)).mapRight((right) => right);
  }
}
