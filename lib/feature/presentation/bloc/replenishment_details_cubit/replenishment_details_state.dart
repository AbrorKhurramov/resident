import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';


class ReplenishmentDetailsState extends Equatable{
  final StateStatus stateStatus;
  final BaseResponse<ReplenishmentDetailsResponse>? response;
  final Failure? failure;

  const ReplenishmentDetailsState({
    required this.stateStatus,
    this.response,
    this.failure,
  });
  ReplenishmentDetailsState copyWith(
      {StateStatus? stateStatus,
        BaseResponse<ReplenishmentDetailsResponse>? response,
        Failure? failure}) {
    return ReplenishmentDetailsState(
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

