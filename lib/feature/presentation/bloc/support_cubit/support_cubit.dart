import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/domain/use_case/support_use_case/get_support_use_case.dart';
import 'package:resident/feature/presentation/bloc/support_cubit/support_state.dart';

class SupportCubit extends RepositoryCubit<SupportState> {
  final GetSupportUseCase getSupportUseCase;

  SupportCubit({required this.getSupportUseCase})
      : super(const SupportState(stateStatus: StateStatus.initial));

  void getSupport(String apartmentId) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    getSupportUseCase
        .call(GetSupportUseCaseParams(apartmentId:apartmentId,filterRequestParam: FilterRequestParam(page: 0), cancelToken:cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) {
             return  emit(state.copyWith(
                  stateStatus: StateStatus.success, response: right));
            }
    );
  }
}
