import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class AppealState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<AppealType>? response;
  final Failure? loadingFailure;
  final Failure? paginationLoadingFailure;

  const AppealState({
    required this.stateStatus,
    this.response,
    this.loadingFailure,
    this.paginationLoadingFailure,
  });

  AppealState copyWith({
    StateStatus? stateStatus,
    BasePaginationListResponse<AppealType>? response,
    Map<String, List<AppealResponse>>? sortedAppeal,
    Failure? loadingFailure,
    Failure? paginationLoadingFailure,
  }) {
    return AppealState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        loadingFailure: loadingFailure,
        paginationLoadingFailure: paginationLoadingFailure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        loadingFailure,
        paginationLoadingFailure,
      ];
}
