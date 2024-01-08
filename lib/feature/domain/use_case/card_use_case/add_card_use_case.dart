import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class AddCardUseCase extends UseCase<BaseResponse<SmsCardResponse>, AddCardUseCaseParams> {
  final CardRepository cardRepository;

  AddCardUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BaseResponse<SmsCardResponse>>> call(AddCardUseCaseParams params) {
    return cardRepository.addCard(
      cardNumber: params.cardNumber,
      expiryDate: params.expiryDate,
      cancelToken: params.cancelToken,
    );
  }
}

class AddCardUseCaseParams extends Equatable {
  final String cardNumber;
  final String expiryDate;
  final CancelToken cancelToken;

  const AddCardUseCaseParams({
    required this.cardNumber,
    required this.expiryDate,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        cardNumber,
        expiryDate,
        cancelToken,
      ];
}
