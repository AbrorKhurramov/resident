import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/pin_code/pin_code_state.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:resident/injection/injection_container.dart';
import 'package:resident/injection/params/pin_code_param.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  late final SetUpPinCodeUseCase _setUpPinCodeUseCase;
  late final RemovePinCodeUseCase _removePinCodeUseCase;

  PinCodeCubit(
      {required SetUpPinCodeUseCase setUpPinCodeUseCase,
      required RemovePinCodeUseCase removePinCodeUseCase,
      required PinCodeState initialState})
      : super(initialState) {
    _setUpPinCodeUseCase = setUpPinCodeUseCase;
    _removePinCodeUseCase = removePinCodeUseCase;
  }

  void removePinCode() async {
    Future<Either<Failure, void>> call = _removePinCodeUseCase.call(const NoParams());
  }

  void setUpPinCode() async {
    Future<Either<Failure, void>> call = _setUpPinCodeUseCase.call(SetUpPinCodeParams(state.newPinCode));
    //_call.fold((left) => print(left.toString()), (right) => print('right'));
    getIt.unregister<PinCodeParam>();
    getIt.registerFactory<PinCodeParam>(() => PinCodeParam(pinCode: state.newPinCode));
  }

  void onKeyboardPressed(String number) {
    switch (state.pinCodeStatus) {
      case PinCodeStatus.setup:
        if (state.currentPinCode.length < 4) {
          emit(state.copyWith(
              currentPinCode: state.currentPinCode.isEmpty ? number : state.currentPinCode + number,
              isCurrentPinCodeFilled: state.currentPinCode.length == 3 ? true : false));
        } else if (state.newPinCode.length < 4) {
          emit(state.copyWith(
              newPinCode: state.newPinCode.isEmpty ? number : state.newPinCode + number,
              isNewPinCodeFilled: state.newPinCode.length == 3 ? true : false));
        } else if (state.confirmPinCode.length < 4) {
          emit(state.copyWith(
              confirmPinCode: state.confirmPinCode + number,
              isConfirmPinCodeFilled: state.confirmPinCode.length == 3 ? true : false));
        }
        break;
      case PinCodeStatus.enter:
        if (state.newPinCode.length < 4) {
          emit(state.copyWith(
              newPinCode: state.newPinCode.isEmpty ? number : state.newPinCode + number,
              isNewPinCodeFilled: state.newPinCode.length == 3 ? true : false));
        } else if (state.confirmPinCode.length < 4) {
          emit(state.copyWith(
              confirmPinCode: state.confirmPinCode + number,
              isConfirmPinCodeFilled: state.confirmPinCode.length == 3 ? true : false));
        }
        break;
      default:
        if (state.currentPinCode.length < 4) {
          emit(state.copyWith(
              currentPinCode: state.currentPinCode.isEmpty ? number : state.currentPinCode + number,
              isCurrentPinCodeFilled: state.currentPinCode.length == 3 ? true : false));
        }
        break;
    }
  }

  void onClearNewPinCodeWithConfirmPinCode() {
    emit(state.copyWith(newPinCode: '', isNewPinCodeFilled: false, confirmPinCode: '', isConfirmPinCodeFilled: false));
  }

  void onClearAllPinCode() {
    emit(state.copyWith(
        currentPinCode: '',
        isCurrentPinCodeFilled: false,
        newPinCode: '',
        isNewPinCodeFilled: false,
        confirmPinCode: '',
        isConfirmPinCodeFilled: false));
  }

  void onRemovePressed() {
    switch (state.pinCodeStatus) {
      case PinCodeStatus.setup:
        if (!state.isCurrentPinCodeFilled && state.currentPinCode.isNotEmpty) {
          emit(state.copyWith(currentPinCode: state.currentPinCode.substring(0, state.currentPinCode.length - 1)));
        } else if (!state.isNewPinCodeFilled && state.newPinCode.isNotEmpty) {
          emit(state.copyWith(newPinCode: state.newPinCode.substring(0, state.newPinCode.length - 1)));
        } else if (!state.isConfirmPinCodeFilled && state.confirmPinCode.isNotEmpty) {
          emit(state.copyWith(confirmPinCode: state.confirmPinCode.substring(0, state.confirmPinCode.length - 1)));
        }
        break;
      case PinCodeStatus.enter:
        if (!state.isNewPinCodeFilled && state.newPinCode.isNotEmpty) {
          emit(state.copyWith(newPinCode: state.newPinCode.substring(0, state.newPinCode.length - 1)));
        } else if (!state.isConfirmPinCodeFilled && state.confirmPinCode.isNotEmpty) {
          emit(state.copyWith(confirmPinCode: state.confirmPinCode.substring(0, state.confirmPinCode.length - 1)));
        }
        break;
      default:
        if (!state.isCurrentPinCodeFilled && state.currentPinCode.isNotEmpty) {
          emit(state.copyWith(currentPinCode: state.currentPinCode.substring(0, state.currentPinCode.length - 1)));
        }
        break;
    }
  }
}
