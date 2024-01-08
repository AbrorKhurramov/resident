import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class PaymentHistoryState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<Payment>? response;
  final Map<String, List<Payment>> sortedPayment;
  final Failure? loadingFailure;
  final Failure? paginationLoadingFailure;

  const PaymentHistoryState({
    required this.stateStatus,
    this.response,
    required this.sortedPayment,
    this.loadingFailure,
    this.paginationLoadingFailure,
  });

  PaymentHistoryState copyWith({
    StateStatus? stateStatus,
    BasePaginationListResponse<Payment>? response,
    Map<String, List<Payment>>? sortedPayment,
    Failure? loadingFailure,
    Failure? paginationLoadingFailure,
  }) {
    return PaymentHistoryState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        sortedPayment: sortedPayment ?? this.sortedPayment,
        loadingFailure: loadingFailure,
        paginationLoadingFailure: paginationLoadingFailure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        sortedPayment,
        loadingFailure,
        paginationLoadingFailure,
      ];
}
