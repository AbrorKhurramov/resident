import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, BasePaginationListResponse<Invoice>>> getInvoiceList({
    required String apartmentId,
    required AppealHistoryParam filterRequestParam,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<Invoice>>> getInvoiceById({
    required String apartmentId,
    required String invoiceId,
    required CancelToken cancelToken,
  });

  Future<Either<Failure, BaseResponse<Invoice>>> payInvoice({
    required String apartmentId,
    required String invoiceId,
    required CancelToken cancelToken,
  });
}
