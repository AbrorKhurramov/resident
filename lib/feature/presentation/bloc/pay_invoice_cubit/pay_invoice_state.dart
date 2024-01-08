import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class PayInvoiceState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<Invoice>? response;
  final Failure? failure;

  const PayInvoiceState(
      {required this.stateStatus, this.response, this.failure});

  PayInvoiceState copyWith(
      {StateStatus? stateStatus,
      BaseResponse<Invoice>? response,
      Failure? failure}) {
    return PayInvoiceState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        failure: failure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        failure,
      ];
}
