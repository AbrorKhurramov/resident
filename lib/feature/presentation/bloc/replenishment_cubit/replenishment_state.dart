import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class ReplenishmentState extends Equatable {
  final StateStatus stateStatus;
  final Failure? failure;
  final BaseResponse<void>? response;

  const ReplenishmentState(
      {required this.stateStatus, this.failure, this.response});

  ReplenishmentState copyWith({
    StateStatus? stateStatus,
    BaseResponse<void>? response,
    Failure? failure,
  }) {
    return ReplenishmentState(
      stateStatus: stateStatus ?? this.stateStatus,
      response: response ?? this.response,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        failure,
        response,
      ];
}
