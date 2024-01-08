import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class CardRepository {

  Future<Either<Failure, BaseResponse<void>>> removeCardById({
    required String cardId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BasePaginationListResponse<CardResponse>>> getCardList({
    required FilterRequestParam filterRequestParam,
    required CancelToken cancelToken,
  });


  Future<Either<Failure, BaseResponse<SmsCardResponse>>> addCard({
    required String cardNumber,
    required String expiryDate,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<void>>> confirmSmsForCard(
      {required ConfirmCardRequest confirmCardRequest, required CancelToken cancelToken});
}
