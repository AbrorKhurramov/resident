import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/card_cubit/card_state.dart';
import 'package:either_dart/either.dart';

class CardCubit extends RepositoryCubit<CardState> {
  final GetCardListUseCase getCardListUseCase;

  CardCubit({
    required this.getCardListUseCase,
  }) : super(CardState(stateStatus: StateStatus.initial));

  void getCardList() async {
    emit(state.copyWith(stateStatus: StateStatus.loading));
    getCardListUseCase
        .call(GetCardListUseCaseParams(filterRequestParam: FilterRequestParam(page: 0), cancelToken: cancelToken))
        .fold((left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(stateStatus: StateStatus.success, response: right)));
  }

  Future<void> getRefreshList() async {
    if (state.stateStatus == StateStatus.loading) return;
    await getCardListUseCase
        .call(GetCardListUseCaseParams(filterRequestParam: FilterRequestParam(page: 0), cancelToken: cancelToken))
        .fold((left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(stateStatus: StateStatus.success, response: right)));
  }
}
