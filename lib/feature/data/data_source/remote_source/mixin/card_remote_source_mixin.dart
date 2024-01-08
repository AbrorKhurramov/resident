import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

mixin CardRemoteSourceMixin implements BaseRequest {

  Future<Either<Exception, BaseResponse<void>>> removeCardById(
      {required String cardId,
        required CancelToken cancelToken}) async {
    return delete(
      '/api/cardlist/$cardId',
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<void>(json)).mapRight((right) {
      return right;
    });
  }


  Future<Either<Exception, BasePaginationListResponse<CardResponse>>> getCardList(
      {required FilterRequestParam filterRequestParam,
      required CancelToken cancelToken}) async {
    return get(
      '/api/cardlist',
      queryParameters: filterRequestParam.queryParameters(),
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<CardResponse>(json)).mapRight((right) {
      return right;
    });
  }

  Future<Either<Exception, BaseResponse<SmsCardResponse>>> addCard(
      {required String cardNumber,
      required String expiryDate,
      required CancelToken cancelToken}) async {
    dynamic queryParameters = {
      'card_number': cardNumber,
      'card_expire_date': expiryDate
    };

    return post(
      '/api/send_sms',
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<SmsCardResponse>(json)).mapRight((right) {
      return right;
    });
  }

  Future<Either<Exception, BaseResponse<void>>> confirmSmsForCard(
      {required ConfirmCardRequest confirmCardRequest,
      required CancelToken cancelToken}) async {
    return post(
      '/api/confirm_sms',
      queryParameters: confirmCardRequest.toJson(),
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<AuthResponse>(json)).mapRight((right) {
      return right;
    });
  }
}
