import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/domain/entity/response/replenishment_details_response.dart';

mixin PaymentRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<Payment>>> getPayments({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    int? size,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = filterRequestParam.queryParameters();
    queryParameters['apartment_id'] = apartmentId;

    return get(
      '/v1/citizen/payment',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Payment>(json)).mapRight((right) => right);
  }
Future<Either<Exception, BaseResponse<ReplenishmentDetailsResponse>>> getReplenishmentDetails({
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters['apartment_id'] = apartmentId;

    return post(
      '/api/get-fee',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<ReplenishmentDetailsResponse>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<void>>> replenishmentBalance({
    required ReplenishmentRequest replenishmentBalanceRequest,
    required CancelToken cancelToken,
  }) async {
    return post(
      '/api/payment',
      queryParameters: replenishmentBalanceRequest.toJson(),
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<void>(json)).mapRight((right) => right);
  }
}
