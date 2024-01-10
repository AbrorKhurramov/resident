import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';


mixin InvoiceRepositoryMixin implements AppRepositoryMixin {
  late final AppRemoteSource appRemoteSource;

  Future<Either<Failure, BasePaginationListResponse<Invoice>>> getInvoiceList(
      {required String apartmentId,
      required AppealHistoryParam filterRequestParam,
      required CancelToken cancelToken}) async {
    Either<Exception, BasePaginationListResponse<Invoice>> response =
        await appRemoteSource.getInvoiceList(
            apartmentId: apartmentId,
            filterRequestParam: filterRequestParam,
            cancelToken: cancelToken);

    return getEitherResponse<BasePaginationListResponse<Invoice>>(response);
  }

  Future<Either<Failure, BaseResponse<Invoice>>> getInvoiceById(
      {required String apartmentId,
      required String invoiceId,
      required CancelToken cancelToken}) async {
    Either<Exception, BaseResponse<Invoice>> response =
        await appRemoteSource.getInvoiceById(
      apartmentId: apartmentId,
      invoiceId: invoiceId,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BaseResponse<Invoice>>(response);
  }

  Future<Either<Failure, BaseResponse<Invoice>>> payInvoice(
      {required String apartmentId,
        required String invoiceId, required CancelToken cancelToken}) async {
    Either<Exception, BaseResponse<Invoice>> response =
        await appRemoteSource.payInvoice(
          apartmentId: apartmentId,
          invoiceId: invoiceId,
      cancelToken: cancelToken,
    );

    return getEitherResponse<BaseResponse<Invoice>>(response);
  }
}
