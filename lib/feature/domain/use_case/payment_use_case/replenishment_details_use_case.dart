import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';


class ReplenishmentDetailsUseCase
    extends UseCase<BaseResponse<ReplenishmentDetailsResponse>, ReplenishmentDetailsUseCaseParams> {
  final PaymentRepository paymentRepository;

  ReplenishmentDetailsUseCase(this.paymentRepository);

  @override
  Future<Either<Failure, BaseResponse<ReplenishmentDetailsResponse>>> call(
      ReplenishmentDetailsUseCaseParams params) {
    return paymentRepository.getReplenishmentDetails(
        apartmentId: params.apartmentId,
          cancelToken: params.cancelToken);
  }
}

class ReplenishmentDetailsUseCaseParams extends Equatable {
  final String apartmentId;
  final CancelToken cancelToken;

  const ReplenishmentDetailsUseCaseParams(
      {required this.apartmentId,
        required this.cancelToken});

  ReplenishmentDetailsUseCaseParams copyWith(
      {String? apartmentId,
        CancelToken? cancelToken}) {
    return ReplenishmentDetailsUseCaseParams(
      apartmentId: apartmentId ?? this.apartmentId,
      cancelToken: cancelToken ?? this.cancelToken,
    );
  }

  @override
  List<Object?> get props => [apartmentId, cancelToken];
}
