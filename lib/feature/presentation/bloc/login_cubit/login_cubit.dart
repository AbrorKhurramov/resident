import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';

import 'package:either_dart/either.dart';
import 'package:resident/feature/presentation/bloc/login_cubit/login_state.dart';
import 'package:resident/injection/injection_container.dart';


class LoginCubit extends RepositoryCubit<LoginState> {
  late final LoginUseCase _loginUseCase;
  late final InsertTokenUseCase _insertTokenUseCase;
  late final InsertUserUseCase _insertUserUseCase;

  AuthResponse? authResponse;

  LoginCubit(
      {required LoginUseCase loginUseCase,
      required InsertUserUseCase insertUserUseCase,
      required InsertTokenUseCase insertTokenUseCase,
      required LoginState initialState})
      : super(initialState) {
    _loginUseCase = loginUseCase;
    _insertUserUseCase = insertUserUseCase;
    _insertTokenUseCase = insertTokenUseCase;
  }

  void login() async {
   String? firebaseToken = await getIt<FirebaseMessaging>().getToken();
print("firebase token$firebaseToken");
    emit(state.copyWith(stateStatus: StateStatus.loading));
    await _loginUseCase
        .call(LoginUseCaseParams(
          AuthRequest(username: state.login, password: state.password,firebaseToken: firebaseToken??""),
          cancelToken,
        ))
        .thenRight((right) {
          authResponse = right;
          print("logToken=${authResponse!.token.accessToken}");
          return  _insertUserUseCase.call(InsertUserUseCaseParams(authResponse!.user));
        })
        .thenRight((right) => _insertTokenUseCase.call(InsertTokenUseCaseParams(authResponse!.token)))
        .fold((left) => emit(state.copyWith(stateStatus: StateStatus.failure, failure: left)), (right) {
          emit(state.copyWith(stateStatus: StateStatus.success, user: authResponse!.user));
        });
  }

  void onChangeLogin(String login) {
    emit(state.copyWith(login: login));
  }

  void onChangePassword(String password) {
    emit(state.copyWith(password: password));
  }
}
