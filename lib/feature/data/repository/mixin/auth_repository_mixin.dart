import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';
import 'package:resident/feature/domain/entity/request/firebase_notification_update_request.dart';

mixin AuthRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, AuthResponse>> login(
      {required AuthRequest authRequest,
      required CancelToken cancelToken}) async {
    Either<Exception, AuthResponse> response = await appRemoteSource.login(
        authRequest: authRequest, cancelToken: cancelToken);

    return getEitherResponse<AuthResponse>(response);
  }

  Future<Either<Failure, User>> getProfile(
      {required CancelToken cancelToken}) async {
    Either<Exception, User> response =
        await appRemoteSource.getProfile(cancelToken);

    return getEitherResponse<User>(response);
  }

  Future<Either<Failure, BaseResponse<void>>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response = await appRemoteSource.changePassword(
        requestBody: changePasswordRequest, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<void>>(response);
  }
  Future<Either<Failure, BaseResponse<void>>> changeFirebaseNotificationState({
    required FirebaseNotificationUpdateRequest firebaseNotificationUpdateRequest,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response = await appRemoteSource.changeFirebaseNotificationState(
        requestBody: firebaseNotificationUpdateRequest, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<void>>(response);
  }

  Future<Either<Failure, BaseResponse<void>>> updateProfile({
    required UserUpdateRequest userUpdateRequest,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response =
        await appRemoteSource.updateProfile(
            requestBody: userUpdateRequest, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<void>>(response);
  }

  Future<Either<Failure, BaseResponse<void>>> changeActiveApartment({
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response =
        await appRemoteSource.changeActiveApartment(
            apartmentId: apartmentId, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<void>>(response);
  }
  Future<Either<Failure, bool>> forceUpdate({
    required String version,
    required String type,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, bool> response =
        await appRemoteSource.forceUpdate(
            version: version,type: type, cancelToken: cancelToken);

    return getEitherResponse<bool>(response);
  }
  Future<Either<Failure, bool>> getFirebaseNotificationState({
    required String firebaseToken,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, bool> response =
        await appRemoteSource.getFirebaseNotificationState(
            firebaseToken: firebaseToken, cancelToken: cancelToken);

    return getEitherResponse<bool>(response);
  }
}
