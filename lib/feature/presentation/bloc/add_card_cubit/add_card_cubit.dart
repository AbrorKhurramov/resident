import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/add_card_cubit/add_card_state.dart';

class AddCardCubit extends RepositoryCubit<AddCardState> {
  final AddCardUseCase addCardUseCase;


  AddCardCubit({required this.addCardUseCase})
      : super(const AddCardState(
          stateStatus: StateStatus.initial,
          cardNumber: '',
          expiryDate: '',
        ));

  void onAddCard() async {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    await addCardUseCase
        .call(
          AddCardUseCaseParams(
            cardNumber: state.cardNumber.replaceAll(' ', ''),
            expiryDate: state.expiryDate.replaceAll('/', ''),
            cancelToken: cancelToken,
          ),
        )
        .fold((left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(stateStatus: StateStatus.success, response: right)));
  }

  void onChangeCardNumber(String changedText) {
    emit(state.copyWith(stateStatus: StateStatus.initial, cardNumber: changedText));
  }

  void onChangeExpiryDate(String changedText) {
    emit(state.copyWith(stateStatus: StateStatus.initial, expiryDate: changedText ));
  }
}
