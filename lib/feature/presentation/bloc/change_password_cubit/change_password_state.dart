import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class ChangePasswordState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<void>? response;
  late final String currentPassword;
  late final String newPassword;
  late final String confirmPassword;
  final Failure? failure;

  ChangePasswordState(
      {required this.stateStatus,
      this.response,
      required this.currentPassword,
      required this.newPassword,
      required this.confirmPassword,
      this.failure}) {
    // currentPassword = currentPassword ?? '';
    // newPassword = newPassword ?? '';
    // confirmPassword = confirmPassword ?? '';
  }

  ChangePasswordState copyWith(
      {StateStatus? stateStatus,
      BaseResponse<void>? response,
      String? currentPassword,
      String? newPassword,
      String? confirmPassword,
      Failure? failure}) {
    return ChangePasswordState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        currentPassword: currentPassword ?? this.currentPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        failure: failure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        currentPassword,
        newPassword,
        confirmPassword,
        failure,
      ];
}
