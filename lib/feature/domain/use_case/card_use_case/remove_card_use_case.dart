import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class RemoveCardUseCase
    extends UseCase<BaseResponse<void>, RemoveCardUseCaseParams> {
  final CardRepository cardRepository;

  RemoveCardUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(
      RemoveCardUseCaseParams params) {
    return cardRepository.removeCardById(
      cardId: params.cardId,
      cancelToken: params.cancelToken,
    );
  }
}

class RemoveCardUseCaseParams extends Equatable {
  final String cardId;
  final CancelToken cancelToken;

  const RemoveCardUseCaseParams({
    required this.cardId,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        cardId,
        cancelToken,
      ];
}
