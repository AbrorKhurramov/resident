import 'package:dio/dio.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

class ChangeApartmentUseCase extends UseCase<BaseResponse<void>, ChangeApartmentUseCaseParams> {
  final AuthRepository authRepository;

  ChangeApartmentUseCase(this.authRepository);

  @override
  Future<Either<Failure, BaseResponse<void>>> call(ChangeApartmentUseCaseParams params) {
    return authRepository.changeActiveApartment(
      apartmentId: params.apartmentId,
      cancelToken: params.cancelToken,
    );
  }
}

class ChangeApartmentUseCaseParams extends Equatable {
  final String apartmentId;
  final CancelToken cancelToken;

  const ChangeApartmentUseCaseParams(this.apartmentId, this.cancelToken);

  @override
  List<Object?> get props => [apartmentId, cancelToken];
}
