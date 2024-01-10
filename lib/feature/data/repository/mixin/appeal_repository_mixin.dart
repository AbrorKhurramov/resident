import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

mixin AppealRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<AppealType>>>
      getAppealTypes({
    required String apartmentId,
    required int page,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BasePaginationListResponse<AppealType>> response =
        await appRemoteSource.getAppealTypes(
      apartmentId: apartmentId,
      page: page,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<AppealType>>(response);
  }

  Future<Either<Failure, BasePaginationListResponse<AppealResponse>>>
      getHistoryAppeals({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BasePaginationListResponse<AppealResponse>> response =
        await appRemoteSource.getHistoryAppeals(
      apartmentId: apartmentId,
      filterRequestParam: filterRequestParam,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<AppealResponse>>(
        response);
  }
  Future<Either<Failure, BaseResponse<AppealResponse>>>
      getHistoryAppealsById({
    required String appealId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<AppealResponse>> response =
        await appRemoteSource.getHistoryAppealsByID(
      appealId: appealId,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BaseResponse<AppealResponse>>(
        response);
  }

  Future<Either<Failure, BaseResponse<AppealResponse>>>
      createAppeal({
    required AppealRequest appealRequest,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<AppealResponse>> response =
        await appRemoteSource.createAppeal(
      appealRequest: appealRequest,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BaseResponse<AppealResponse>>(
        response);
  }
}
