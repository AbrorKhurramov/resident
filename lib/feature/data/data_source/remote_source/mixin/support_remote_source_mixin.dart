import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import '../../../../domain/entity/response/support.dart';



mixin SupportRemoteSourceMixin implements BaseRequest{


  Future<Either<Exception, BasePaginationListResponse<Support>>>
  getSupport({
    required String apartmentId,
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = filterRequestParam.queryParameters();
    queryParameters['apartment_id'] = apartmentId;

    return get(
      '/v1/citizen/company-contact',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<Support>(json))
        .mapRight((right) => right);
  }

}