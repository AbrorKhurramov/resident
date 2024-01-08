import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/create_appeal_cubit/create_appeal_state.dart';
import 'package:either_dart/either.dart';

class CreateAppealCubit extends RepositoryCubit<CreateAppealState> {
  final CreateAppealUseCase createAppealUseCase;

  CreateAppealCubit({required this.createAppealUseCase}) : super(CreateAppealState(stateStatus: StateStatus.initial));

  void createAppeal(AppealRequest appealRequest) {
    emit(state.copyWith(stateStatus: StateStatus.loading));
    createAppealUseCase.call(CreateAppealUseCaseParams(appealRequest, cancelToken)).fold(
        (left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
        (right) => emit(state.copyWith(stateStatus: StateStatus.success, response: right)));
  }
}
