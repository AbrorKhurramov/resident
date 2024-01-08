import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';


mixin PaymentRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<Payment>>> getPayments({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BasePaginationListResponse<Payment>> response =
        await appRemoteSource.getPayments(
            apartmentId: apartmentId,
            filterRequestParam: filterRequestParam,
            cancelToken: cancelToken);

    return getEitherResponse<BasePaginationListResponse<Payment>>(response);
  }
  Future<Either<Failure, BaseResponse<ReplenishmentDetailsResponse>>> getReplenishmentDetails({
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<ReplenishmentDetailsResponse>> response =
        await appRemoteSource.getReplenishmentDetails(
            apartmentId: apartmentId,
            cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<ReplenishmentDetailsResponse>>(response);
  }

  Future<Either<Failure, BaseResponse<void>>> replenishmentBalance({
    required ReplenishmentRequest replenishmentBalanceRequest,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response =
        await appRemoteSource.replenishmentBalance(
      replenishmentBalanceRequest: replenishmentBalanceRequest,
      cancelToken: cancelToken,
    );

    return getEitherResponse(response);
  }
}
