import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/domain/entity/param/indication_history_param.dart';
import 'package:resident/feature/presentation/bloc/service_result_cubit/service_result_state.dart';
import 'package:either_dart/either.dart';

class ServiceResultCubit extends RepositoryCubit<ServiceResultState> {
  final GetServiceResultUseCase getServiceResultUseCase;

  ServiceResultCubit({required this.getServiceResultUseCase})
      : super(ServiceResultState(stateStatus: StateStatus.initial));


  void getServiceList(int type , String apartmentId) {
    emit(state.copyWith(stateStatus: StateStatus.loading,));

    getServiceResultUseCase
        .call(GetServiceResultUseCaseParams(
            type: type,
            apartmentId: apartmentId,
            filterRequestParam: IndicationHistoryParam(page: 0, size: 4),
            cancelToken: cancelToken))
        .fold(
            (left) {
              if(left is CancelFailure) return;
              emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left));
            },
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }
}
