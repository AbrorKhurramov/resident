import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class MyFlatState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<void>? response;
  final Failure? failure;

  const MyFlatState({required this.stateStatus, this.response, this.failure});

  MyFlatState copyWith({StateStatus? stateStatus, BaseResponse<void>? response, Failure? failure}) {
    return MyFlatState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [stateStatus, response, failure];
}
