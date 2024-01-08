import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class PaymentRepository {
  Future<Either<Failure, BasePaginationListResponse<Payment>>> getPayments({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    required CancelToken cancelToken,
  });
Future<Either<Failure, BaseResponse<ReplenishmentDetailsResponse>>> getReplenishmentDetails({
    required String apartmentId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<void>>> replenishmentBalance({
    required ReplenishmentRequest replenishmentBalanceRequest,
    required CancelToken cancelToken,
  });



}
