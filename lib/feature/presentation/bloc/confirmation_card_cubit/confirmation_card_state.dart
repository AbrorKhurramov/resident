import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class ConfirmationCardState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<void>? response;
  final String smsCode;
  final Failure? failure;

  const ConfirmationCardState({
    required this.stateStatus,
    required this.smsCode,
    this.response,
    this.failure,
  });

  ConfirmationCardState copyWith(
      {StateStatus? stateStatus, String? smsCode, BaseResponse<void>? response, Failure? failure}) {
    return ConfirmationCardState(
        stateStatus: stateStatus ?? this.stateStatus,
        smsCode: smsCode ?? this.smsCode,
        response: response ?? this.response,
        failure: failure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        smsCode,
        response,
        failure,
      ];
}
