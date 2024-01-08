import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class CreateInvoiceState extends Equatable {
  final StateStatus stateStatus;
  final Counter counter;
  final String? reading;
  final BaseResponse<void>? response;
  final Failure? failure;

  const CreateInvoiceState({
    required this.stateStatus,
    required this.counter,
    this.reading,
    this.response,
    this.failure,
  });

  CreateInvoiceState copyWith(
      {StateStatus? stateStatus,
      Counter? counter,
      String? reading,
        BaseResponse<void>? response,
      Failure? failure}) {
    return CreateInvoiceState(
      stateStatus: stateStatus ?? this.stateStatus,
      counter: counter ?? this.counter,
      reading: reading ?? this.reading,
      response: response ?? this.response,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        counter,
        reading,
        response,
        failure,
      ];
}
