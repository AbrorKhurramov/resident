import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import '../../entity/param/indication_history_param.dart';

abstract class CounterRepository {
  Future<Either<Failure, BasePaginationListResponse<Counter>>> getCounterList({
    required int type,
    required String apartmentId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<void>>> createInvoice({
    required String apartmentId,
    required String serviceId,
    required String servicePriceId,
    required int result,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BasePaginationListResponse<ServiceResult>>> getServiceResultList({
    required int type,
    required String apartmentId,
    required IndicationHistoryParam indicationHistoryParam,
    required CancelToken cancelToken,
  });
}
