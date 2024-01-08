import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/feature/domain/entity/request/firebase_notification_update_request.dart';

import '../../../../../injection/injection_container.dart';

mixin AuthRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, Token>> refreshToken(
      {required Token token, required CancelToken cancelToken}) async {

    return post(
      '/v1/auth/refresh',
      data: token,
      headers: {
        'client-token': '2TV62sDk04k4D4m8qnNdtHJgs5BLToA4dWeKdydL',
        'Content-Type': 'application/json'},
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Token>(json)).mapRight((right) {
      Token token = right as Token;
      addToken(token);
      return token;
    });
  }

  Future<Either<Exception, AuthResponse>> login(
      {required AuthRequest authRequest,
      required CancelToken cancelToken}) async {


    return post(
      '/v1/auth/login',
      data: authRequest,
      headers: {
        'client-token': '2TV62sDk04k4D4m8qnNdtHJgs5BLToA4dWeKdydL',
        'Content-Type': 'application/json'},
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<AuthResponse>(json)).mapRight((right) {
      AuthResponse authResponse = right as AuthResponse;
      addToken(authResponse.token);
      return authResponse;
    });
  }
  Future<Either<Exception, bool>> forceUpdate(
      {required String version,
        required String type,
      required CancelToken cancelToken}) async {
    print("DIO HEADER HERE");
    print(getIt<Dio>().options.headers.toString());

    return post(
      '/v1/citizen/mobile-version',
      queryParameters: {
        "version":version,
        "type":type
      },
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<bool>(json)).mapRight((right) {
      return (right as BaseResponse).data;
    });
  }
  Future<Either<Exception, bool>> getFirebaseNotificationState(
      {required String firebaseToken,
      required CancelToken cancelToken}) async {

    return get(
      '/v1/citizen/mobile-version',
      queryParameters: {
        "mobileToken":firebaseToken
      },
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<bool>(json)).mapRight((right) {
      return (right as BaseResponse).data;
    });
  }

  Future<Either<Exception, User>> getProfile(CancelToken cancelToken) async {
    return get(
      '/v1/profile',
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<User>(json))
        .mapRight((right) => right as User);
  }

  Future<Either<Exception, BaseResponse<void>>> changePassword({
    required ChangePasswordRequest requestBody,
    required CancelToken cancelToken,
  }) async {
    return post(
      '/v1/profile',
      data: requestBody,
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<String>(json))
        .mapRight((right) => right as BaseResponse<void>);
  }
  Future<Either<Exception, BaseResponse<void>>> changeFirebaseNotificationState({
    required FirebaseNotificationUpdateRequest requestBody,
    required CancelToken cancelToken,
  }) async {
    return post(
      '/v1/profile/notification',
      data: requestBody,
      cancelToken: cancelToken,
    )
        .thenRight((json) => parseJson<String>(json))
        .mapRight((right) => right as BaseResponse<void>);
  }

  Future<Either<Exception, BaseResponse<void>>> updateProfile({
    required UserUpdateRequest requestBody,
    required CancelToken cancelToken,
  }) async {
    return put(
      '/v1/profile',
      data: requestBody,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<String>(json)).mapRight((right) => right);
  }

  Future<Either<Exception, BaseResponse<void>>> changeActiveApartment({
    required String apartmentId,
    required CancelToken cancelToken,
  }) async {
    return post(
      '/v1/citizen/apartment/change-apartment/$apartmentId',
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<void>(json)).mapRight((right) => right);
  }
}
