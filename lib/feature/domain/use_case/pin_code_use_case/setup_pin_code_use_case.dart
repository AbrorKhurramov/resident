import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/domain/repository/pin_code_repository/pin_code_repository.dart';

class SetUpPinCodeUseCase extends UseCase<void, SetUpPinCodeParams> {
  final PinCodeRepository _pinCodeRepository;

  SetUpPinCodeUseCase(this._pinCodeRepository);

  @override
  Future<Either<Failure, void>> call(SetUpPinCodeParams params) {
    return _pinCodeRepository.setPinCode(params.pinCode);
  }
}

class SetUpPinCodeParams extends Equatable {
  final String pinCode;

  const SetUpPinCodeParams(this.pinCode);

  @override
  List<Object?> get props => [pinCode];
}
