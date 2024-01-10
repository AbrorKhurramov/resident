import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class AppealRepository {
  Future<Either<Failure, BasePaginationListResponse<AppealType>>>
      getAppealTypes({
    required String apartmentId,
    required int page,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BasePaginationListResponse<AppealResponse>>>
      getHistoryAppeals({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    required CancelToken cancelToken,
  });
Future<Either<Failure, BaseResponse<AppealResponse>>>
      getHistoryAppealsById({
    required String appealId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<AppealResponse>>>
      createAppeal({
    required AppealRequest appealRequest,
    required CancelToken cancelToken,
  });
}
