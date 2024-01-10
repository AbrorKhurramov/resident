import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/replenishment_cubit/replenishment_state.dart';
import 'package:either_dart/either.dart';

class ReplenishmentCubit extends RepositoryCubit<ReplenishmentState> {
  final ReplenishmentUseCase replenishmentUseCase;

  ReplenishmentCubit(this.replenishmentUseCase)
      : super(const ReplenishmentState(stateStatus: StateStatus.initial));

  void replenishmentBalance(String cardId, String personalAccount, int amount) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    replenishmentUseCase
        .call(ReplenishmentUseCaseParams(
            ReplenishmentRequest(
              cardId: cardId,
              personalAccount: personalAccount,
              amount: amount * 100,
            ),
            cancelToken))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }
}
