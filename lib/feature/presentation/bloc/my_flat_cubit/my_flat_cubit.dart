import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/my_flat_cubit/my_flat_state.dart';
import 'package:either_dart/either.dart';

class MyFlatCubit extends RepositoryCubit<MyFlatState> {
  final ChangeApartmentUseCase changeApartmentUseCase;

  MyFlatCubit({required this.changeApartmentUseCase}) : super(MyFlatState(stateStatus: StateStatus.initial));

  void changeActiveApartment(String apartmentId) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    changeApartmentUseCase.call(ChangeApartmentUseCaseParams(apartmentId, cancelToken)).fold(
        (left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
        (right) => emit(state.copyWith(stateStatus: StateStatus.success, response: right)));
  }
}
