import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';

class GetNotificationUseCase extends UseCase<bool, GetNotificationUseCaseParams> {

  final AuthRepository authRepository;

  GetNotificationUseCase(this.authRepository);

  @override
  Future<Either<Failure, bool>> call(GetNotificationUseCaseParams params) {
    return authRepository.getFirebaseNotificationState(firebaseToken: params.firebaseToken, cancelToken: params.cancelToken);
  }
}

class GetNotificationUseCaseParams extends Equatable {
  final String firebaseToken;
  final CancelToken cancelToken;

  const GetNotificationUseCaseParams(this.firebaseToken, this.cancelToken);

  @override
  List<Object?> get props => [firebaseToken,cancelToken];


}
