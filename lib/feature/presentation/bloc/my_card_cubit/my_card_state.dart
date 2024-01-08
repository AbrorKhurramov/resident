import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class MyCardState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<void>? removeResponse;
  final Failure? failure;

  const MyCardState({
    required this.stateStatus,
    this.removeResponse,
    this.failure,
  });

  MyCardState copyWith(
      {StateStatus? stateStatus,
      BasePaginationListResponse<CardResponse>? response,
      BaseResponse<void>? removeResponse,
      Failure? failure}) {
    return MyCardState(
        stateStatus: stateStatus ?? this.stateStatus,
        removeResponse: removeResponse ?? this.removeResponse,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        removeResponse,
        failure,
      ];
}
