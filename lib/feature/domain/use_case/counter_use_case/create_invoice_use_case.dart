import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class CreateInvoiceUseCase
    extends UseCase<BaseResponse<void>, CreateInvoiceUseCaseParams> {
  final CounterRepository cardRepository;

  CreateInvoiceUseCase(this.cardRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(
      CreateInvoiceUseCaseParams params) {
    return cardRepository.createInvoice(
      apartmentId: params.apartmentId,
      serviceId: params.serviceId,
      servicePriceId: params.servicePriceId,
      result: params.result,
      cancelToken: params.cancelToken,
    );
  }
}

class CreateInvoiceUseCaseParams extends Equatable {
  final String apartmentId;
  final String serviceId;
  final String servicePriceId;
  final int result;
  final CancelToken cancelToken;

  const CreateInvoiceUseCaseParams({
    required this.apartmentId,
    required this.serviceId,
    required this.servicePriceId,
    required this.result,
    required this.cancelToken,
  });

  @override
  List<Object?> get props => [
        apartmentId,
        serviceId,
    servicePriceId,
        result,
        cancelToken,
      ];
}
