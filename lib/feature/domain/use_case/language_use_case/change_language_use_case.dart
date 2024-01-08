import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';

class ChangeLanguageUseCase implements UseCase<void, ChangeLanguageParams> {
  final LanguageRepository _languageRepository;

  ChangeLanguageUseCase(this._languageRepository);

  @override
  Future<Either<Failure, void>> call(ChangeLanguageParams params) {
    return _languageRepository.setLanguageCode(params.changedLanguageCode);
  }
}

class ChangeLanguageParams extends Equatable {
  final String changedLanguageCode;

  const ChangeLanguageParams(this.changedLanguageCode);

  @override
  List<Object?> get props => [changedLanguageCode];
}
