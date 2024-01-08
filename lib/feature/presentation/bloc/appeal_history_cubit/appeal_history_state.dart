import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class AppealHistoryState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<AppealResponse>? response;
  final Map<String, List<AppealResponse>> sortedAppeal;
  final Failure? loadingFailure;
  final Failure? paginationLoadingFailure;

  const AppealHistoryState({
    required this.stateStatus,
    this.response,
    required this.sortedAppeal,
    this.loadingFailure,
    this.paginationLoadingFailure,
  });

  AppealHistoryState copyWith({
    StateStatus? stateStatus,
    BasePaginationListResponse<AppealResponse>? response,
    Map<String, List<AppealResponse>>? sortedAppeal,
    Failure? loadingFailure,
    Failure? paginationLoadingFailure,
  }) {
    return AppealHistoryState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        sortedAppeal: sortedAppeal ?? this.sortedAppeal,
        loadingFailure: loadingFailure,
        paginationLoadingFailure: paginationLoadingFailure);
  }

  @override
  List<Object?> get props =>
      [
        stateStatus,
        response,
        sortedAppeal,
        loadingFailure,
        paginationLoadingFailure,
      ];
}
