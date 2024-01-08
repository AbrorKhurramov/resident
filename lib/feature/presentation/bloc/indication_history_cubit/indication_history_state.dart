import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class IndicationHistoryState extends Equatable {
  final StateStatus stateStatus;
  final int type;
  final BasePaginationListResponse<ServiceResult>? response;
  final Map<String, List<ServiceResult>> sortedIndication;
  final Failure? loadingFailure;
  final Failure? paginationLoadingFailure;

  const IndicationHistoryState({
    required this.stateStatus,
    required this.type,
    this.response,
    required this.sortedIndication,
    this.loadingFailure,
    this.paginationLoadingFailure,
  });

  IndicationHistoryState copyWith({
    StateStatus? stateStatus,
    int? type,
    BasePaginationListResponse<ServiceResult>? response,
    Map<String, List<ServiceResult>>? sortedIndication,
    Failure? loadingFailure,
    Failure? paginationLoadingFailure,
  }) {
    return IndicationHistoryState(
        stateStatus: stateStatus ?? this.stateStatus,
        type: type ?? this.type,
        response: response ?? this.response,
        sortedIndication: sortedIndication ?? this.sortedIndication,
        loadingFailure: loadingFailure,
        paginationLoadingFailure: paginationLoadingFailure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        sortedIndication,
        loadingFailure,
        paginationLoadingFailure,
      ];
}
