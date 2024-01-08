import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class ServiceResultState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<ServiceResult>? response;
  final Failure? failure;

  const ServiceResultState({
    required this.stateStatus,
    this.response,
    this.failure,
  });

  ServiceResultState copyWith(
      {StateStatus? stateStatus,
      BasePaginationListResponse<ServiceResult>? response,
      Failure? failure}) {
    return ServiceResultState(
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
