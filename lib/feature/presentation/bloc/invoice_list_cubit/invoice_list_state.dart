import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class InvoiceListState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<Invoice>? response;
  final Failure? loadingFailure;
  final Failure? paginationFailure;
  final bool? isNotification;


  const InvoiceListState(
      {required this.stateStatus,
      this.response,
      this.loadingFailure,
      this.isNotification,
      this.paginationFailure});

  InvoiceListState copyWith({
    StateStatus? stateStatus,
    BasePaginationListResponse<Invoice>? response,
    Failure? loadingFailure,
    Failure? paginationFailure,
    bool? isNotification,

  }) {
    return InvoiceListState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        loadingFailure: loadingFailure,
        isNotification: isNotification ?? this.isNotification,
        paginationFailure: paginationFailure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        loadingFailure,
        paginationFailure,
        isNotification,
      ];
}
