import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class InvoiceUseCase
    extends UseCase<BaseResponse<Invoice>, InvoiceUseCaseParams> {
  final InvoiceRepository invoiceRepository;

  InvoiceUseCase(this.invoiceRepository);

  @override
  Future<Either<Failure, BaseResponse<Invoice>>> call(
      InvoiceUseCaseParams params) {
    return invoiceRepository.getInvoiceById(
        apartmentId: params.apartmentId,
        invoiceId: params.invoiceId,
        cancelToken: params.cancelToken);
  }
}

class InvoiceUseCaseParams extends Equatable {
  final String apartmentId;
  final String invoiceId;
  final CancelToken cancelToken;

  const InvoiceUseCaseParams(
      this.apartmentId, this.invoiceId, this.cancelToken);

  @override
  List<Object?> get props => [invoiceId, cancelToken];
}
