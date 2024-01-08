import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class ReplenishmentUseCase extends UseCase<BaseResponse<void>, ReplenishmentUseCaseParams> {
  final PaymentRepository paymentRepository;

  ReplenishmentUseCase(this.paymentRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(ReplenishmentUseCaseParams params) {
    return paymentRepository.replenishmentBalance(
      replenishmentBalanceRequest: params.request,
      cancelToken: params.cancelToken,
    );
  }
}

class ReplenishmentUseCaseParams extends Equatable {
  final ReplenishmentRequest request;
  final CancelToken cancelToken;

  const ReplenishmentUseCaseParams(this.request, this.cancelToken);

  ReplenishmentUseCaseParams copyWith({ReplenishmentRequest? request, CancelToken? cancelToken}) {
    return ReplenishmentUseCaseParams(
      request ?? this.request,
      cancelToken ?? this.cancelToken,
    );
  }

  @override
  List<Object?> get props => [request, cancelToken];
}
