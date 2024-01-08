import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class LoginUseCase extends UseCase<AuthResponse, LoginUseCaseParams> {
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, AuthResponse>> call(LoginUseCaseParams params) {
    return authRepository.login(authRequest: params.authRequest, cancelToken: params.cancelToken);
  }
}

class LoginUseCaseParams extends Equatable {
  final AuthRequest authRequest;
  final CancelToken cancelToken;

  const LoginUseCaseParams(this.authRequest, this.cancelToken);

  @override
  List<Object?> get props => [authRequest, cancelToken];
}
