import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class PayInvoiceUseCase
    extends UseCase<BaseResponse<Invoice>, PayInvoiceUseCaseParams> {
  final InvoiceRepository invoiceRepository;

  PayInvoiceUseCase(this.invoiceRepository);

  @override
  Future<Either<Failure, BaseResponse<Invoice>>> call(
      PayInvoiceUseCaseParams params) {
    return invoiceRepository.payInvoice(apartmentId: params.apartmentId,
        invoiceId: params.invoiceId, cancelToken: params.cancelToken);
  }
}

class PayInvoiceUseCaseParams extends Equatable {
  final String apartmentId;
  final String invoiceId;
  final CancelToken cancelToken;

  const PayInvoiceUseCaseParams(this.apartmentId,this.invoiceId, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId,invoiceId, cancelToken];
}
