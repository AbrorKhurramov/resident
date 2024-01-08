import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

mixin NotificationsCountRemoteSourceMixin implements BaseRequest {


  Future<Either<Exception, BaseResponse<NotificationsCount>>> getNotificationsCount({
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    return get(
      '/v1/profile/notifications/$apartmentId',
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<NotificationsCount>(json)).mapRight((right) => right);
  }
}
