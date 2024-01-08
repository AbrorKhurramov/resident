import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import '../../entity/request/firebase_notification_update_request.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login({
    required AuthRequest authRequest,
    required CancelToken cancelToken,
  });
  Future<Either<Failure, bool>> forceUpdate({
    required String version,
    required String type,
    required CancelToken cancelToken,
  });
  Future<Either<Failure, bool>> getFirebaseNotificationState({
    required String firebaseToken,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, User>> getProfile({required CancelToken cancelToken});

  Future<Either<Failure, BaseResponse<void>>> changePassword({
    required ChangePasswordRequest changePasswordRequest,
    required CancelToken cancelToken,
  });
  Future<Either<Failure, BaseResponse<void>>> changeFirebaseNotificationState({
    required FirebaseNotificationUpdateRequest firebaseNotificationUpdateRequest,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<void>>> updateProfile({
    required UserUpdateRequest userUpdateRequest,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<void>>> changeActiveApartment({
    required String apartmentId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, void>> insertUser(User user);

  Future<Either<Failure, void>> insertToken(Token token);

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, void>> deleteToken();
}
