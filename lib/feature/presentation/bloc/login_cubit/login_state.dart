import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class LoginState extends Equatable {
  final StateStatus stateStatus;
  final User? user;
  final String login;
  final String password;
  final String firebaseToken;
  final Failure? failure;

  const LoginState({required this.stateStatus, this.user, required this.login, required this.password,required this.firebaseToken, this.failure});

  LoginState copyWith({StateStatus? stateStatus, User? user, String? login, String? password,String? firebaseToken, Failure? failure}) {
    return LoginState(
        stateStatus: stateStatus ?? this.stateStatus,
        user: user ?? this.user,
        login: login ?? this.login,
        password: password ?? this.password,
        firebaseToken: firebaseToken ?? this.firebaseToken,
        failure: failure);
  }

  @override
  List<Object?> get props => [stateStatus, login, password,firebaseToken, failure];
}
