import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class SupportState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<Support>? response;
  final Failure? failure;

  const SupportState({required this.stateStatus, this.response, this.failure});

  SupportState copyWith(
      {StateStatus? stateStatus,
      BasePaginationListResponse<Support>? response,
      Failure? failure}) {
    return SupportState(
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
