import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class CreateAppealState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<AppealResponse>? response;
  final Failure? failure;

  const CreateAppealState({required this.stateStatus, this.response, this.failure});

  CreateAppealState copyWith({StateStatus? stateStatus, BaseResponse<AppealResponse>? response, Failure? failure}) {
    return CreateAppealState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [stateStatus, response, failure];
}
