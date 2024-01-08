import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class InvoiceListUseCase
    extends UseCase<BasePaginationListResponse<Invoice>, InvoiceListUseCaseParams> {
  final InvoiceRepository invoiceRepository;

  InvoiceListUseCase(this.invoiceRepository);

  @override
  Future<Either<Failure, BasePaginationListResponse<Invoice>>> call(
      InvoiceListUseCaseParams params) {
    return invoiceRepository.getInvoiceList(
        apartmentId: params.apartmentId,
        filterRequestParam: params.filterRequestParam,
        cancelToken: params.cancelToken);
  }
}

class InvoiceListUseCaseParams extends Equatable {
  final String apartmentId;
  final AppealHistoryParam filterRequestParam;
  final CancelToken cancelToken;

  const InvoiceListUseCaseParams(
      this.apartmentId, this.filterRequestParam, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId, filterRequestParam, cancelToken];
}
