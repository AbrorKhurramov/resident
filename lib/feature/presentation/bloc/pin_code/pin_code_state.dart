import 'package:equatable/equatable.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';

class PinCodeState extends Equatable {
  final PinCodeStatus pinCodeStatus;
  final String? activePinCode;
  late final String currentPinCode;
  late final String newPinCode;
  late final String confirmPinCode;
  late final bool isCurrentPinCodeFilled;
  late final bool isNewPinCodeFilled;
  late final bool isConfirmPinCodeFilled;
  late final bool isNotSamePinCode;

  PinCodeState(
      {required this.pinCodeStatus,
      this.activePinCode,
      String? currentPinCode,
      String? newPinCode,
      String? confirmPinCode,
      bool? isCurrentPinCodeFilled,
      bool? isNewPinCodeFilled,
      bool? isConfirmPinCodeFilled,
      bool? isNotSamePinCode}) {
    this.currentPinCode = currentPinCode ?? '';
    this.newPinCode = newPinCode ?? '';
    this.confirmPinCode = confirmPinCode ?? '';
    this.isCurrentPinCodeFilled = isCurrentPinCodeFilled ?? false;
    this.isNewPinCodeFilled = isNewPinCodeFilled ?? false;
    this.isConfirmPinCodeFilled = isConfirmPinCodeFilled ?? false;
    this.isNotSamePinCode = isNotSamePinCode ?? false;
  }

  PinCodeState copyWith(
      {PinCodeStatus? pinCodeStatus,
      String? activePinCode,
      String? currentPinCode,
      String? newPinCode,
      String? confirmPinCode,
      bool? isCurrentPinCodeFilled,
      bool? isNewPinCodeFilled,
      bool? isConfirmPinCodeFilled,
      bool? isNotSamePinCode}) {
    return PinCodeState(
        pinCodeStatus: pinCodeStatus ?? this.pinCodeStatus,
        activePinCode: activePinCode ?? this.activePinCode,
        currentPinCode: currentPinCode ?? this.currentPinCode,
        newPinCode: newPinCode ?? this.newPinCode,
        confirmPinCode: confirmPinCode ?? this.confirmPinCode,
        isCurrentPinCodeFilled:
            isCurrentPinCodeFilled ?? this.isCurrentPinCodeFilled,
        isNewPinCodeFilled: isNewPinCodeFilled ?? this.isNewPinCodeFilled,
        isConfirmPinCodeFilled:
            isConfirmPinCodeFilled ?? this.isConfirmPinCodeFilled,
        isNotSamePinCode: isNotSamePinCode ?? this.isNotSamePinCode);
  }

  @override
  List<Object?> get props => [
        pinCodeStatus,
        activePinCode,
        currentPinCode,
        newPinCode,
        confirmPinCode,
        isCurrentPinCodeFilled,
        isNewPinCodeFilled,
        isConfirmPinCodeFilled,
        isNotSamePinCode
      ];
}
