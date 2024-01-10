import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/confirmation_card_cubit/confirmation_card_state.dart';
import 'package:either_dart/either.dart';


class ConfirmationCardCubit extends RepositoryCubit<ConfirmationCardState> {
  final ConfirmationCardUseCase confirmationCardUseCase;

  ConfirmationCardCubit({required this.confirmationCardUseCase})
      : super(const ConfirmationCardState(
          stateStatus: StateStatus.initial,
          smsCode: '',
        ));

  void confirmation(SmsCardResponse smsCardResponse,String lang) {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    confirmationCardUseCase
        .call(ConfirmationCardUseCaseParams(
          confirmCardRequest: ConfirmCardRequest(
            cardNumber: smsCardResponse.cardNumber,
            expiryDate: smsCardResponse.expiryDate,
            phoneNumber: smsCardResponse.phoneNumber,
            confirmId: smsCardResponse.confirmId,
            confirmSms: state.smsCode,
            lang: lang,
          ),
          cancelToken: cancelToken,
        ))
        .fold((left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(stateStatus: StateStatus.success, response: right)));
  }

  void completeSMSCode(smsCode) {
    emit(state.copyWith(smsCode: smsCode));
  }

  void changeSmsCard(String newChar, int index) {
    String newSmsCode = _replaceCharAt(state.smsCode, index, newChar);
    emit(state.copyWith(smsCode: newSmsCode,stateStatus: StateStatus.initial));
  }

  String _replaceCharAt(String oldString, int index, String newChar) {
    if (oldString.length - 1 >= index) {
      return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
    }
    return oldString.substring(0, index) + newChar;
  }
}
