import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class CounterState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<Counter>? responseColdWater;
  final BasePaginationListResponse<Counter>? responseHotWater;
  final BasePaginationListResponse<Counter>? responseElectric;
  final BasePaginationListResponse<Counter>? responseGas;
  final Failure? failure;

  const CounterState(
      {required this.stateStatus,
      this.responseColdWater,
      this.responseHotWater,
      this.responseElectric,
      this.responseGas,
      this.failure});

  CounterState copyWith(
      {StateStatus? stateStatus,
      BasePaginationListResponse<Counter>? responseColdWater,
      BasePaginationListResponse<Counter>? responseHotWater,
      BasePaginationListResponse<Counter>? responseElectric,
      BasePaginationListResponse<Counter>? responseGas,
      Failure? failure}) {
    return CounterState(
        stateStatus: stateStatus ?? this.stateStatus,
        responseColdWater: responseColdWater ?? this.responseColdWater,
        responseHotWater: responseHotWater ?? this.responseHotWater,
        responseElectric: responseElectric ?? this.responseElectric,
        responseGas: responseGas ?? this.responseGas,
        failure: failure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        responseColdWater,
        responseHotWater,
        responseElectric,
        responseGas,
        failure,
      ];
}
