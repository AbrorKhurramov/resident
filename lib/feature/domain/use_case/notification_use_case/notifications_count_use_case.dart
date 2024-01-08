import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/feature/domain/repository/notification_repository/notifications_count_repository.dart';


class NotificationsCountUseCase extends UseCase<
    BaseResponse<NotificationsCount>, NotificationsCountUseCaseParams> {
  final NotificationsCountRepository notificationsCountRepository;

  NotificationsCountUseCase(this.notificationsCountRepository);

  @override
  Future<Either<Failure, BaseResponse<NotificationsCount>>> call(
      NotificationsCountUseCaseParams params) {
    return notificationsCountRepository.getNotificationsCount(
        apartmentId: params.apartmentId,
        cancelToken: params.cancelToken);
  }
}

class NotificationsCountUseCaseParams extends Equatable {
  final String apartmentId;
  final CancelToken cancelToken;

  const NotificationsCountUseCaseParams(
      this.apartmentId, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId, cancelToken];
}
