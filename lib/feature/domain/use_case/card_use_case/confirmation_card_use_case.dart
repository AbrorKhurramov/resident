import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class ConfirmationCardUseCase extends UseCase<BaseResponse<void>, ConfirmationCardUseCaseParams> {
  final CardRepository cardRepository;

  ConfirmationCardUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(ConfirmationCardUseCaseParams params) {
    return cardRepository.confirmSmsForCard(
      confirmCardRequest: params.confirmCardRequest,
      cancelToken: params.cancelToken,
    );
  }
}

class ConfirmationCardUseCaseParams extends Equatable {
  final ConfirmCardRequest confirmCardRequest;
  final CancelToken cancelToken;

  const ConfirmationCardUseCaseParams({
    required this.confirmCardRequest,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        confirmCardRequest,
        cancelToken,
      ];
}
