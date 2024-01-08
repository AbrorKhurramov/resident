import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/domain/use_case/auth_use_case/force_update_use_case.dart';
import 'package:resident/feature/presentation/bloc/splash_cubit/splash_state.dart';

import '../../../../core/extension/my_new_version.dart';



class SplashCubit extends RepositoryCubit<SplashState> {

  late final ForceUpdateUseCase _forceUpdateUseCase;


  SplashCubit(
  {
    required ForceUpdateUseCase forceUpdateUseCase
}
      ) : super(const SplashState(isForceUpdate: false,stateStatus: StateStatus.initial)){
   _forceUpdateUseCase = forceUpdateUseCase;
  }


  Future<void> forceUpdate() async{
    emit(state.copyWith(stateStatus: StateStatus.loading));
    var versionStatus = await NewVersion().getVersionStatus();

String platform = Platform.isAndroid?"ANDROID":"IOS";
     await _forceUpdateUseCase.call(ForceUpdateUseCaseParams(versionStatus!.localVersion, platform, cancelToken)).
     fold((left) =>
         emit(state.copyWith(stateStatus: StateStatus.failure,failure: left)),
            (right) => emit(state.copyWith(stateStatus: StateStatus.success,isForceUpdate: right)));
  }



}
