import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/feature/presentation/bloc/payment_history_cubit/payment_history_state.dart';

class PaymentHistoryCubit extends RepositoryCubit<PaymentHistoryState> {
  late final PaymentHistoryUseCase _paymentHistoryUseCase;

  PaymentHistoryCubit(PaymentHistoryUseCase paymentHistoryUseCase)
      : super(const PaymentHistoryState(
          stateStatus: StateStatus.initial,
          sortedPayment: {},
        )) {
    _paymentHistoryUseCase = paymentHistoryUseCase;
  }

  void getPaymentHistory(int page, String apartmentId, String dateFrom, String dateTo,int? type,) async {
    emit(state.copyWith(stateStatus: StateStatus.loading,sortedPayment: const {}));
    await _paymentHistoryUseCase
        .call(PaymentHistoryUseCaseParams(
          apartmentId: apartmentId,
          filterRequestParam: AppealHistoryParam(page: page,dateFrom: dateFrom, dateTo: dateTo,type: type),
          cancelToken: cancelToken,
        ))
        .fold(
          (left) => emit(state.copyWith(
              stateStatus: StateStatus.failure, loadingFailure: left)),
          (right) => emit(state.copyWith(
              stateStatus: StateStatus.success,
              response: right.copyWith(data: right.data),
              sortedPayment: _sortPaymentHistory(right.data,true))),
        );
  }

  void getPaginationPaymentHistory(int page, String apartmentId, String dateFrom, String dateTo,int? type) async {
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));

    await _paymentHistoryUseCase
        .call(PaymentHistoryUseCaseParams(
          apartmentId: apartmentId,
          filterRequestParam: AppealHistoryParam(page: page,dateFrom: dateFrom,dateTo: dateTo,type: type),
          cancelToken: cancelToken,
        ))
        .fold(
          (left) => emit(state.copyWith(
              stateStatus: StateStatus.paginationFailure,
              paginationLoadingFailure: left)),
          (right) => emit(state.copyWith(
              stateStatus: StateStatus.success,
              response: right.copyWith(
                  totalPages: right.totalPages,
                  currentPage: right.currentPage,
                  totalItems: right.totalItems,
                  statusMessage: right.statusMessage,
                  statusCode: right.statusCode,
                  data: [...state.response!.data, ...right.data]),
              sortedPayment: _sortPaymentHistory(right.data,false))),
        );
  }

  Map<String, List<Payment>> _sortPaymentHistory(List<Payment> newData,bool isFirst) {
    Map<String, List<Payment>> newMap = isFirst? {} : {...state.sortedPayment};
    for (Payment payment in newData) {
      String createdDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('yyyy-MM-dd').parse(payment.createdDate!));

      if (newMap[createdDate] == null) {
        newMap[createdDate] = [payment];
      } else {
        newMap[createdDate] = [...newMap[createdDate]!, payment];
      }
    }
    return newMap;
  }

}
