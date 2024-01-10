import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/injection/params/permission_param.dart';

class ByBiometricsPermissionCubit extends Cubit<bool> {
  final GetPermissionUseCase getPermissionUseCase;
  final SetPermissionUseCase setPermissionUseCase;

  ByBiometricsPermissionCubit(
      {required this.getPermissionUseCase,
      required this.setPermissionUseCase,
      required bool initialState})
      : super(initialState);

  void turnOnPermission() {
     setPermissionUseCase
        .call(const SetPermissionParams(true))
        .fold((left) => null, (right) {
      getIt.unregister<PermissionParam>();
      getIt.registerFactory<PermissionParam>(
          () => PermissionParam(permission: true));
      emit(true);
    });
  }

  void turnOffPermission() {
    setPermissionUseCase
        .call(const SetPermissionParams(false))
        .fold((left) => null, (right) {
      getIt.unregister<PermissionParam>();
      getIt.registerFactory<PermissionParam>(
          () => PermissionParam(permission: false));
      emit(false);
    });
  }
}
