import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';


mixin InvoiceRemoteSourceMixin implements BaseRequest {
  Future<Either<Exception, BasePaginationListResponse<Invoice>>> getInvoiceList(
      {required String apartmentId,
      required AppealHistoryParam filterRequestParam,
      required CancelToken cancelToken}) async {
    Map<String, dynamic> map = filterRequestParam.queryParameters();
    map['apartment_id'] = apartmentId;

    return get(
      '/v1/citizen/invoice/',
      queryParameters: map,
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Invoice>(json)).mapRight((right) {
      return right;
    });
  }

  Future<Either<Exception, BaseResponse<Invoice>>> payInvoice({
    required String apartmentId,
    required String invoiceId,
    required CancelToken cancelToken,
  }) async {
    return post(
      '/v1/citizen/invoice/close-invoice/',
      queryParameters: {
        "id": invoiceId,
        "apartment_id": apartmentId,
      },
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Invoice>(json)).mapRight((right) {
      return right;
    });
  }

  Future<Either<Exception, BaseResponse<Invoice>>> getInvoiceById({
    required String apartmentId,
    required String invoiceId,
    required CancelToken cancelToken,
  }) async {
    return post(
      '/v1/citizen/invoice/',
      queryParameters: {
        "id": invoiceId,
        "apartment_id": apartmentId,
      },
      cancelToken: cancelToken,
    ).thenRight((json) => parseJson<Invoice>(json)).mapRight((right) {
      return right;
    });
  }
}
