

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

import '../../../../core/error/failure.dart';
import '../../data_source/remote_source/app_remote_source.dart';

mixin NotificationsCountRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BaseResponse<NotificationsCount>>>
  getNotificationsCount({
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<NotificationsCount>> response =
    await appRemoteSource.getNotificationsCount(
      apartmentId: apartmentId,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BaseResponse<NotificationsCount>>(
        response);
  }
}