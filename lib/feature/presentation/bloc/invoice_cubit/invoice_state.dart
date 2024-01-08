import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class InvoiceState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<Invoice>? response;
  final Failure? failure;

  const InvoiceState({required this.stateStatus, this.response, this.failure});

  InvoiceState copyWith(
      {StateStatus? stateStatus,
      BaseResponse<Invoice>? response,
      Failure? failure}) {
    return InvoiceState(
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
