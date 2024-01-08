import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/feature/domain/entity/request/firebase_notification_update_request.dart';

import '../../entity/response/base_response.dart';

class SetUpNotificationUseCase extends UseCase<void, SetUpNotificationParams> {
  final AuthRepository authRepository;

  SetUpNotificationUseCase(this.authRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(SetUpNotificationParams params) {
    return authRepository.changeFirebaseNotificationState(
      firebaseNotificationUpdateRequest: params.firebaseNotificationUpdateRequest,
      cancelToken: params.cancelToken,
    );
  }
}

class SetUpNotificationParams extends Equatable {
  final FirebaseNotificationUpdateRequest firebaseNotificationUpdateRequest;
  final CancelToken cancelToken;

  const SetUpNotificationParams(this.firebaseNotificationUpdateRequest,this.cancelToken);

  @override
  List<Object?> get props => [firebaseNotificationUpdateRequest,cancelToken];
}
