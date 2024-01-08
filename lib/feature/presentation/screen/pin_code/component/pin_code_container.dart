import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PinCodeContainer extends StatefulWidget {
  const PinCodeContainer({Key? key}) : super(key: key);

  @override
  State<PinCodeContainer> createState() => _PinCodeContainerState();
}

class _PinCodeContainerState extends State<PinCodeContainer> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return BlocConsumer<PinCodeCubit, PinCodeState>(
      listener: (context, state) {
        _checkPinCode(state);
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _initCircleContainer(_getActive(state, 1), state.pinCodeStatus == PinCodeStatus.setup),
            AppDimension.horizontalSize_24,
            _initCircleContainer(_getActive(state, 2), state.pinCodeStatus == PinCodeStatus.setup),
            AppDimension.horizontalSize_24,
            _initCircleContainer(_getActive(state, 3), state.pinCodeStatus == PinCodeStatus.setup),
            AppDimension.horizontalSize_24,
            _initCircleContainer(_getActive(state, 4), state.pinCodeStatus == PinCodeStatus.setup),
          ],
        );
      },
    );
  }

  void _checkPinCode(PinCodeState state) {
    switch (state.pinCodeStatus) {
      case PinCodeStatus.setup:
        if (state.isCurrentPinCodeFilled && state.currentPinCode != state.activePinCode) {
          showErrorFlushBar(context, _appLocalization.error_active_pin_code);
          context.read<PinCodeCubit>().onClearAllPinCode();
        } else if (state.isNewPinCodeFilled &&
            state.isConfirmPinCodeFilled &&
            state.newPinCode == state.confirmPinCode) {
          context.read<PinCodeCubit>().setUpPinCode();
          Navigator.pop(context);
          showSuccessFlushBar(context, _appLocalization.pin_code_success_setup);
        } else if (state.isNewPinCodeFilled &&
            state.isConfirmPinCodeFilled &&
            state.newPinCode != state.confirmPinCode) {
          context.read<PinCodeCubit>().onClearNewPinCodeWithConfirmPinCode();
          showErrorFlushBar(context, _appLocalization.error_different_pin_code);
        }
        break;
      case PinCodeStatus.enter:
        if (state.isNewPinCodeFilled && state.isConfirmPinCodeFilled && state.newPinCode == state.confirmPinCode) {
          context.read<PinCodeCubit>().setUpPinCode();
          dismissFlushBar();
          Navigator.of(context).pushReplacementNamed(AppRouteName.dashboardScreen);
        } else if (state.isNewPinCodeFilled &&
            state.isConfirmPinCodeFilled &&
            state.newPinCode != state.confirmPinCode) {
          showErrorFlushBar(context, _appLocalization.error_different_pin_code);
          context.read<PinCodeCubit>().onClearNewPinCodeWithConfirmPinCode();
        }
        break;
      default:
        if (state.isCurrentPinCodeFilled && state.currentPinCode == state.activePinCode) {
          dismissFlushBar();
          Navigator.of(context).pushReplacementNamed(AppRouteName.dashboardScreen);
        } else if (state.isCurrentPinCodeFilled && state.currentPinCode != state.activePinCode) {
          context.read<PinCodeCubit>().onClearAllPinCode();
          showErrorFlushBar(context, _appLocalization.error_confirm_pin_code);
        }
        break;
    }
  }

  bool _getActive(PinCodeState pinCodeState, int index) {
    switch (pinCodeState.pinCodeStatus) {
      case PinCodeStatus.setup:
        if (pinCodeState.currentPinCode.isNotEmpty &&
            pinCodeState.currentPinCode.length >= index &&
            !pinCodeState.isCurrentPinCodeFilled) {
          return true;
        } else if (pinCodeState.newPinCode.isNotEmpty &&
            pinCodeState.newPinCode.length >= index &&
            !pinCodeState.isNewPinCodeFilled) {
          return true;
        } else if (pinCodeState.confirmPinCode.isNotEmpty &&
            pinCodeState.confirmPinCode.length >= index &&
            !pinCodeState.isConfirmPinCodeFilled) {
          return true;
        }
        return false;

      case PinCodeStatus.enter:
        if (pinCodeState.newPinCode.isNotEmpty &&
            pinCodeState.newPinCode.length >= index &&
            !pinCodeState.isNewPinCodeFilled) {
          return true;
        } else if (pinCodeState.confirmPinCode.isNotEmpty &&
            pinCodeState.confirmPinCode.length >= index &&
            !pinCodeState.isConfirmPinCodeFilled) {
          return true;
        }
        return false;

      default:
        if (pinCodeState.currentPinCode.isNotEmpty &&
            pinCodeState.currentPinCode.length >= index &&
            !pinCodeState.isCurrentPinCodeFilled) {
          return true;
        }
        return false;
    }
  }

  _initCircleContainer(bool active, bool light) {
    return SizedBox(
      width: 24,
      height: 24,
      child: Container(
        decoration: BoxDecoration(
          color: active
              ? light
                  ? Colors.black
                  : Colors.white
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: light ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5)),
        ),
      ),
    );
  }
}
