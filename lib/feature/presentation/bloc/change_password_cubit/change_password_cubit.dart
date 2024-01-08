import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';

import 'package:either_dart/either.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends RepositoryCubit<ChangePasswordState> {
  late final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordCubit(ChangePasswordUseCase changePasswordUseCase)
      : super(ChangePasswordState(
            stateStatus: StateStatus.initial,
            currentPassword: "",
            newPassword: "",
            confirmPassword: "")) {
    _changePasswordUseCase = changePasswordUseCase;
  }

  void changePassword() async {
    emit(state.copyWith(stateStatus: StateStatus.loading));

    await _changePasswordUseCase
        .call(ChangePasswordUseCaseParams(
          ChangePasswordRequest(
            currentPassword: state.currentPassword,
            newPassword: state.newPassword,
          ),
          cancelToken,
        ))
        .fold(
            (left) => emit(state.copyWith(
                stateStatus: StateStatus.failure, failure: left)),
            (right) => emit(state.copyWith(
                stateStatus: StateStatus.success, response: right)));
  }

  void onChangeCurrentPassword(String currentPassword) {
    emit(state.copyWith(
        stateStatus: StateStatus.initial, currentPassword: currentPassword));
  }

  void onChangeNewPassword(String newPassword) {
    emit(state.copyWith(
        stateStatus: StateStatus.initial, newPassword: newPassword));
  }

  void onChangeConfirmPassword(String confirmPassword) {
    emit(state.copyWith(
        stateStatus: StateStatus.initial, confirmPassword: confirmPassword));
  }
}
