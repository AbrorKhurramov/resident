import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_arrow_card.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/permission_component.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:resident/feature/presentation/screen/security/component/change_password_bottom_sheet.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/security/component/profile_bottom_sheet.dart';

import '../../../../injection/params/permission_param.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;
  bool isChangedProfile = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
 providers: [
   BlocProvider(
       create: (_) => ByBiometricsPermissionCubit(
           getPermissionUseCase: getIt<GetPermissionUseCase>(),
           setPermissionUseCase: getIt<SetPermissionUseCase>(),
           initialState: getIt<PermissionParam>().permission)),
 ],
  child: WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, isChangedProfile);
        return false;
      },
      child: Scaffold(
        body: Container(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/part_first_gradient.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    label: _appLocalization.security.capitalize(),
                    voidCallback: () {
                      Navigator.pop(context, isChangedProfile);
                    },
                  ),
                  AppDimension.verticalSize_16,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppArrowCard(
                          label: _appLocalization.change_password.capitalize(),
                          onPressed: _onPressedChangePassword),
                    ),
                  ),
                  AppDimension.verticalSize_16,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppArrowCard(
                          label: _appLocalization.set_up_pin_code.capitalize(),
                          onPressed: _onPressedSetupPinCode),
                    ),
                  ),
                  AppDimension.verticalSize_16,
                  const Flexible(
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: PermissionComponent())),
                  AppDimension.verticalSize_16,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppArrowCard(
                          label: _appLocalization.personal_data.capitalize(),
                          onPressed: () {
                            _onPressedProfile(
                                context.read<AppCubit>().state.user!.logo);
                          }),
                    ),
                  ),
                ],
              ),
            )),
      ),
    ),
);
  }

  Widget _iniPermission() {
    return BlocBuilder<ByBiometricsPermissionCubit, bool>(
  builder: (context, state) {
    return ElevatedButton(
      onPressed:(){
        _onPressedPermission(!state);
      } ,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blue, fixedSize: const Size(double.infinity, 64), backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _appLocalization.login_by_biometrics.capitalize(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
              ),
            ),
            AppDimension.horizontalSize_8,
            CupertinoSwitch(value: state, onChanged: (changed) {
              _onPressedPermission(changed);
            })
          ],
        ),
      ),
    );
  },
);
  }

  _onPressedChangePassword() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (_) => getIt<ChangePasswordCubit>(),
            child: const ChangePasswordBottomSheet(),
          );
        });
  }

  _onPressedSetupPinCode() {
    Navigator.pushNamed(context, AppRouteName.pinCodeScreen,
        arguments: PinCodeStatus.setup);
  }

  void _onPressedPermission(bool permission) {
    if (permission) {
      context.read<ByBiometricsPermissionCubit>().turnOnPermission();
    } else {
      context.read<ByBiometricsPermissionCubit>().turnOffPermission();
    }
  }

  _onPressedProfile(ImageFile? imageFile) {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider(
              create: (_) => AppImageCubit(
                  sendFileUseCase: getIt<SendFileUseCase>(),
                  imageFile: imageFile != null ? [imageFile] : []),
            ),
            BlocProvider(
              create: (_) => getIt<ProfileCubit>(),
            ),
          ], child: const ProfileBottomSheet());
        }).then((value) {
      if (value != null && value == true) {
        isChangedProfile = true;
      }
    });
  }
}
