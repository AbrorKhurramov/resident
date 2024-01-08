import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/appeal_cubit/appeal_state.dart';
import 'package:either_dart/either.dart';

class AppealCubit extends RepositoryCubit<AppealState> {
  late final AppealTypesUseCase _appealTypesUseCase;

  AppealCubit(AppealTypesUseCase appealTypesUseCase)
      : super(const AppealState(
          stateStatus: StateStatus.initial,
        )) {
    _appealTypesUseCase = appealTypesUseCase;
  }

  void getInitialAppeal(String apartmentId, int page) async {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    if (page == 0) {
      await _appealTypesUseCase
          .call(AppealTypesUseCaseParams(apartmentId, page, cancelToken))
          .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, loadingFailure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)),
          );
    } else {
      await _appealTypesUseCase
          .call(AppealTypesUseCaseParams(apartmentId, page, cancelToken))
          .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.paginationFailure,
                paginationLoadingFailure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success,
                response: right.copyWith(
                    totalPages: right.totalPages,
                    currentPage: right.currentPage,
                    totalItems: right.totalItems,
                    statusMessage: right.statusMessage,
                    statusCode: right.statusCode,
                    data: [...state.response!.data, ...right.data]))),
          );
    }
  }
}
