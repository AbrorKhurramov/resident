import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/my_card_cubit/my_card_state.dart';
import 'package:either_dart/either.dart';

class MyCardCubit extends RepositoryCubit<MyCardState> {
  final RemoveCardUseCase removeCardUseCase;

  MyCardCubit({
    required this.removeCardUseCase,
  }) : super(const MyCardState(stateStatus: StateStatus.initial));

  void deleteCard(CardResponse cardResponse) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    removeCardUseCase
        .call(RemoveCardUseCaseParams(
          cardId: cardResponse.id!,
          cancelToken: cancelToken,
        ))
        .fold(
            (left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                  stateStatus: StateStatus.success,
                  removeResponse: right,
                )));
  }
}
