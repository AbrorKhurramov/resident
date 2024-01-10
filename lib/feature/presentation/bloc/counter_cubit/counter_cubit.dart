import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/counter_cubit/counter_state.dart';
import 'package:either_dart/either.dart';

import '../../../../app_package/domain/entity_package.dart';

class CounterCubit extends RepositoryCubit<CounterState> {
  final GetCounterListUseCase getCounterListUseCase;

  CounterCubit({required this.getCounterListUseCase})
      : super(const CounterState(stateStatus: StateStatus.initial));

  Future<void> getCounterList(String apartmentId) async{

    emit(state.copyWith(stateStatus: StateStatus.loading));

    BasePaginationListResponse<Counter>? responseColdWater;
    BasePaginationListResponse<Counter>? responseHotWater;
    BasePaginationListResponse<Counter>? responseElectricity;

   await getCounterListUseCase
        .call(GetCounterListUseCaseParams(
            type: 3, apartmentId: apartmentId, cancelToken: cancelToken))
        .thenRight((right) {
      responseColdWater = right;
      return getCounterListUseCase.call(GetCounterListUseCaseParams(
          type: 2, apartmentId: apartmentId, cancelToken: cancelToken));
    }).thenRight((right) {
      responseHotWater = right;
      return getCounterListUseCase.call(GetCounterListUseCaseParams(
          type: 1, apartmentId: apartmentId, cancelToken: cancelToken));
    }).thenRight((right){
      responseElectricity = right;
      return getCounterListUseCase.call(GetCounterListUseCaseParams(
          type: 4, apartmentId: apartmentId, cancelToken: cancelToken));
    } ).fold(
            (left) {
              if(left is CancelFailure) return;
              emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left));
            },
            (right) => emit(state.copyWith(
                  stateStatus: StateStatus.success,
                  responseColdWater: responseColdWater,
                  responseHotWater: responseHotWater,
                  responseGas: right,
                  responseElectric: responseElectricity,
                )));
  }

  Future<void> setInitial() async{
    emit(state.copyWith(stateStatus: StateStatus.success,
    responseColdWater: null,
    responseElectric: null,
    responseGas: null,
    responseHotWater: null));
  }


}
