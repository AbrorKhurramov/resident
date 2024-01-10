import 'package:resident/core/extension/size_extension.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:resident/feature/presentation/screen/login/component/language_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/login/component/support_bottom_sheet.dart';

import '../../../../injection/injection_container.dart';
import '../../app_route/app_route_name.dart';
import '../../component/app_modal_bottom_sheet.dart';
import '../../component/app_text_field.dart';

class ChangePhoneScreen extends StatefulWidget {

   const ChangePhoneScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePhoneScreenState();
  }
}

class _ChangePhoneScreenState extends State<ChangePhoneScreen> {

  late AppLocalizations _appLocalization;
  final TextEditingController _newPhoneController = TextEditingController();

  final FocusNode _newPhoneFocus = FocusNode();
  final maskFormatter = MaskTextInputFormatter(mask: '(##) ### ## ##');
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;

  }

  @override
  void dispose() {
    super.dispose();
    _newPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:  (_) => getIt<ProfileCubit>(),
      child: Scaffold(
          body: SingleChildScrollView(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Container(
                  width: AppConfig.screenWidth(context),
                  height: AppConfig.screenHeight(context),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/splash_bg.png',
                        ),
                        fit: BoxFit.fill),
                  ),
                  child: BlocBuilder<AppCubit, AppState>(
  builder: (context, appState) {
      return SafeArea(
                    child: Column(
                      children: [
                        AppDimension.verticalSize_24,
                        _initAppBarWithLanguage(),
                        Center(
                          child: SvgPicture.asset('assets/icons/change_phone.svg'),
                        ),
                        AppDimension.verticalSize_20,
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 48),
                              child: Text(_appLocalization.change_admin_phone.capitalize(),style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15.sf(context),color: Colors.white,letterSpacing: 2),maxLines: 2,textAlign:TextAlign.center,)),
                        ),
                        AppDimension.verticalSize_20,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AppTextField(
                            textFormField: TextFormField(
                              controller: _newPhoneController,
                              focusNode: _newPhoneFocus,
                              inputFormatters: [maskFormatter],
                              maxLength: 16,
                              obscureText: false,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 17.sf(context), color: Colors.white),
                              decoration: InputDecoration(
                                  isDense: true,
                                  counterText: "",
                                  contentPadding: EdgeInsets.zero,
                                  border: InputBorder.none,
                                  hintText: "(90) 123 45 67",
                                  prefixIcon: Text(
                                    "+998 ",
                                    style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 17.sf(context), color: Colors.white),
                                  ),
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(fontSize: 17.sf(context), color: Colors.white.withOpacity(0.3))),

                            ),
                            focusNode: _newPhoneFocus,
                            borderColor: Colors.white.withOpacity(0.5),
                            label: _appLocalization.phone.capitalize(),
                            hintLabel: _appLocalization.phone.capitalize(),
                            labelColor: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<NotInternetCubit, bool>(
                          builder: (context, internetState) {
                            return BlocConsumer<ProfileCubit, ProfileState>(
                              listener: (context, state) {
                                if (state.stateStatus == StateStatus.success) {
                                  Navigator.of(context).pushReplacementNamed(AppRouteName.pinCodeScreen);
                                }
                              },
                              builder: (context, profileState) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 36),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.c6000, disabledForegroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.12)),
                                      onPressed:
                                          _validate(_newPhoneController.text)&& internetState ? () {
                                        context.read<ProfileCubit>().updateProfile(
                                            appState.user!.firstName,
                                            appState.user!.lastName,
                                            _getPhoneNumber(_newPhoneController.text),
                                            appState.user!.logo!=null? appState.user!.logo!.id.toString():null
                                            );
                                      }
                                          : null,
                                      child: profileState.stateStatus == StateStatus.loading
                                          ? const CupertinoActivityIndicator(radius: 12)
                                          : Text(_appLocalization.save.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                                );
                              },
                            );
                          },
                        )

                      ],
                    ),
                  );
  },
)),
            ),
          )),
    );
  }


  bool _validate(String newPhone) {
if(newPhone.length!=14) return false;
    return true;
  }
String _getPhoneNumber(String text){
    String phone = text;
    phone = phone.replaceAll("(", "").replaceAll(")", "").replaceAll(" ", "");
    phone = "998$phone";
    return phone;
}

  _initAppBarWithLanguage() {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 20,
              child: InkWell(
                onTap: _onPressedSupport,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white)),
                  child:
                  Center(
                    child: SvgPicture.asset('assets/icons/support.svg'),
                  ),
                ),
              )),
          const Positioned(top: 0, right: 0, child: LanguageComponent())
        ],
      ),
    );
  }

  _onPressedSupport() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider(
              create: (_) => getIt<SupportCubit>(),
              child: SupportBottomSheet(isLogin: true));
        });
  }

}
