import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/domain/repository/pin_code_repository/pin_code_repository.dart';
import 'package:resident/injection/injection_container.dart';
import 'package:resident/injection/params/pin_code_param.dart';

class RemovePinCodeUseCase extends UseCase<void, NoParams> {
  final PinCodeRepository _pinCodeRepository;

  RemovePinCodeUseCase(this._pinCodeRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    getIt.unregister<PinCodeParam>();
    getIt.registerFactory<PinCodeParam>(() => PinCodeParam(pinCode: null));
    return _pinCodeRepository.removePinCode();
  }
}
