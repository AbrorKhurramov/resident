import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';

mixin CardRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BaseResponse<void>>> removeCardById({
    required String cardId,
    required CancelToken cancelToken,
  }) async {
    Either<Exception, BaseResponse<void>> response = await appRemoteSource
        .removeCardById(cardId: cardId, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<void>>(response);
  }

  Future<Either<Failure, BasePaginationListResponse<CardResponse>>> getCardList(
      {required FilterRequestParam filterRequestParam,
      required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<CardResponse>> response =
        await appRemoteSource.getCardList(
            filterRequestParam: filterRequestParam, cancelToken: cancelToken);

    return getEitherResponse<BasePaginationListResponse<CardResponse>>(response);
  }

  Future<Either<Failure, BaseResponse<SmsCardResponse>>> addCard(
      {required String cardNumber,
      required String expiryDate,
      required CancelToken cancelToken}) async {
    Either<Exception, BaseResponse<SmsCardResponse>> response =
        await appRemoteSource.addCard(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<SmsCardResponse>>(response);
  }

  Future<Either<Failure, BaseResponse<void>>> confirmSmsForCard(
      {required ConfirmCardRequest confirmCardRequest,
      required CancelToken cancelToken}) async {
    Either<Exception, BaseResponse<void>> response =
        await appRemoteSource.confirmSmsForCard(
            confirmCardRequest: confirmCardRequest, cancelToken: cancelToken);

    return getEitherResponse<BaseResponse<void>>(response);
  }
}
