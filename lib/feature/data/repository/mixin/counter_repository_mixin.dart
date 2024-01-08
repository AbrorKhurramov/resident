import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

import '../../../domain/entity/param/indication_history_param.dart';

mixin CounterRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<Counter>>> getCounterList(
      {required int type,
      required String apartmentId,
      required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<Counter>> response =
        await appRemoteSource.getCounterList(
      type: type,
      apartmentId: apartmentId,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<Counter>>(response);
  }

  Future<Either<Failure, BaseResponse<void>>> createInvoice({
    required String apartmentId,
    required String serviceId,
    required String servicePriceId,
    required int result,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response =
        await appRemoteSource.createInvoice(
      apartmentId: apartmentId,
      serviceId: serviceId,
      servicePriceId: servicePriceId,
      result: result,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BaseResponse<void>>(response);
  }

  Future<Either<Failure, BasePaginationListResponse<ServiceResult>>>
      getServiceResultList({
    required int type,
    required String apartmentId,
    required IndicationHistoryParam indicationHistoryParam,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BasePaginationListResponse<ServiceResult>> response =
        await appRemoteSource.getServiceResultList(
      type: type,
      apartmentId: apartmentId,
      indicationHistoryParam: indicationHistoryParam,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<ServiceResult>>(
        response);
  }
}
