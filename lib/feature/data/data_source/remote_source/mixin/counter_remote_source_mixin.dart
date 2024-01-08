import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import '../../../../domain/entity/param/indication_history_param.dart';

mixin CounterRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<Counter>>>
      getCounterList({
    required int type,
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['id'] = type;
    queryParameters['apartment_id'] = apartmentId;

    return post(
      '/v1/citizen/counters/counters-list',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Counter>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<void>>> createInvoice({
    required String apartmentId,
    required String serviceId,
    required String servicePriceId,
    required int result,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> data = {
      'apartment_id': apartmentId,
      'service_id': serviceId,
      'service_price_id': servicePriceId,
      'result': result
    };

    return post(
      '/v1/citizen/counters/create-invoice',
      data: data,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<void>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BasePaginationListResponse<ServiceResult>>>
      getServiceResultList({
    required int type,
    required String apartmentId,
    required IndicationHistoryParam indicationHistoryParam,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = indicationHistoryParam.queryParameters();
    queryParameters['type'] = type;
    queryParameters['apartment_id'] = apartmentId;



    return get(
      '/v1/citizen/counters/service-results',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<ServiceResult>(json))
        .mapRight((right) => right);
  }
}
