import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class PaymentHistoryUseCase
    extends UseCase<BasePaginationListResponse<Payment>, PaymentHistoryUseCaseParams> {
  final PaymentRepository paymentRepository;

  PaymentHistoryUseCase(this.paymentRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<Payment>>> call(
      PaymentHistoryUseCaseParams params) {
    return paymentRepository.getPayments(
        apartmentId: params.apartmentId,
        filterRequestParam: params.filterRequestParam,
        cancelToken: params.cancelToken);
  }
}

class PaymentHistoryUseCaseParams extends Equatable {
  final String apartmentId;
  final AppealHistoryParam filterRequestParam;
  final CancelToken cancelToken;

  const PaymentHistoryUseCaseParams(
      {required this.apartmentId,
      required this.filterRequestParam,
      required this.cancelToken});

  PaymentHistoryUseCaseParams copyWith(
      {String? apartmentId,
      AppealHistoryParam? filterRequestParam,
      CancelToken? cancelToken}) {
    return PaymentHistoryUseCaseParams(
      apartmentId: apartmentId ?? this.apartmentId,
      filterRequestParam: filterRequestParam ?? this.filterRequestParam,
      cancelToken: cancelToken ?? this.cancelToken,
    );
  }

  @override
  List<Object?> get props => [apartmentId, filterRequestParam, cancelToken];
}
