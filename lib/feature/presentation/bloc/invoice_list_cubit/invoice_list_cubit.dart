import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:either_dart/either.dart';

class InvoiceListCubit extends RepositoryCubit<InvoiceListState> {
  final InvoiceListUseCase invoiceListUseCase;


  InvoiceListCubit({required this.invoiceListUseCase})
      : super(const InvoiceListState(stateStatus: StateStatus.initial));

  void getInvoiceList(String apartmentId,int? status,int? type, String dateFrom, String dateTo) {
    print("get invoice list");
    emit(state.copyWith(stateStatus: StateStatus.loading));
    invoiceListUseCase
        .call(InvoiceListUseCaseParams(
            apartmentId,
        AppealHistoryParam(page: 0,status: status,type: type,dateFrom: dateFrom,dateTo: dateTo),
            cancelToken))
        .fold(
            (left) {
              if(left is CancelFailure) return;
            emit(state.copyWith(
                stateStatus: StateStatus.failure, loadingFailure: left));
            },
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }

  void getPaginationInvoiceList(
      String apartmentId, int page, String dateFrom, String dateTo,int? status,int? type) {
    print("get Pagination");
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));
    invoiceListUseCase
        .call(InvoiceListUseCaseParams(
            apartmentId,
            AppealHistoryParam(page: page, dateFrom: dateFrom, dateTo: dateTo,status: status,type: type),
            cancelToken))
        .fold(
          (left) => emit(state.copyWith(
              stateStatus: StateStatus.paginationFailure,
              paginationFailure: left)),
          (right) => emit(
            state.copyWith(
              stateStatus: StateStatus.success,
              response: state.response!.copyWith(
                  totalItems: right.totalPages,
                  currentPage: right.currentPage,
                  totalPages: right.totalPages,
                  statusCode: right.statusCode,
                  statusMessage: right.statusMessage,
                  data: [
                    ...state.response!.data,
                    ...right.data,
                  ]),
            ),
          ),
        );
  }

  void updateInvoiceColor(bool? isNotification) {
    emit(state.copyWith(isNotification: isNotification));
  }
}
