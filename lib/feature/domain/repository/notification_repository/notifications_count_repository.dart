import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';


abstract class NotificationsCountRepository {
  Future<Either<Failure, BaseResponse<NotificationsCount>>>
  getNotificationsCount({
    required String apartmentId,
    required CancelToken cancelToken,
  });

}