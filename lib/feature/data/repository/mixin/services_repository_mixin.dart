

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

import '../../../../core/error/failure.dart';
import '../../data_source/remote_source/app_remote_source.dart';

mixin ServicesRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<MerchantResponse>>>
  getServicesList({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BasePaginationListResponse<MerchantResponse>> response =
    await appRemoteSource.getServicesList(
      filterRequestParam: filterRequestParam,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BasePaginationListResponse<MerchantResponse>>(
        response);
  }
}