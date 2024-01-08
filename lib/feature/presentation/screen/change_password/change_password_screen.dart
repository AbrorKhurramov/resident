import 'package:resident/core/extension/size_extension.dart';

import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:resident/feature/presentation/component/app_text_field.dart';
import 'package:resident/feature/presentation/screen/login/component/language_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/login/component/support_bottom_sheet.dart';
import 'package:resident/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_route/app_route_name.dart';
import '../../component/app_modal_bottom_sheet.dart';

class ChangePasswordScreen extends StatefulWidget {
  static Route<dynamic> route(String currentPassword) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => getIt<ChangePasswordCubit>(),
        child: ChangePasswordScreen(currentPassword: currentPassword),
      );
    });
  }
final String currentPassword;
   const ChangePasswordScreen({Key? key,required this.currentPassword}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordScreenState();
  }
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  late AppLocalizations _appLocalization;
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;

  }

  @override
  void dispose() {
    super.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: SafeArea(
                  child: Column(
                    children: [
                      AppDimension.verticalSize_24,
                      _initAppBarWithLanguage(),
                      AppDimension.verticalSize_20,
                      Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48),
                            child: Text(_appLocalization.change_admin_password.capitalize(),style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 15.sf(context),color: Colors.white,letterSpacing: 2),maxLines: 4,textAlign:TextAlign.center,)),
                      ),
                      AppDimension.verticalSize_32,
                      BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: AppTextField(
                              textFormField: TextFormField(
                                controller: _newPasswordController,
                                focusNode: _newPasswordFocus,
                                onFieldSubmitted: (v){
                                  FocusScope.of(context).requestFocus(_confirmFocus);
                                },
                                maxLength: 32,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                onChanged: _onChangeNewCurrentPassword,
                                style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: Colors.white),
                                decoration: InputDecoration(
                                    isDense: true,
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: _appLocalization.new_password_hint_label
                                        .capitalize(),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontSize: 17.sf(context), color: Colors.white.withOpacity(0.3))),
                              ),
                              focusNode: _newPasswordFocus,
                              borderColor: Colors.white.withOpacity(0.5),
                              label: _appLocalization.new_password.toUpperCase(),
                              hintLabel: _appLocalization.new_password_hint_label.capitalize(),
                              labelColor: Colors.white,
                            ),
                          );
                        },
                      ),
                      AppDimension.verticalSize_24,
                      BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: AppTextField(
                              textFormField: TextFormField(
                                controller: _confirmPasswordController,
                                focusNode: _confirmFocus,
                                maxLength: 32,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                                onChanged: _onChangeConfirmCurrentPassword,
                                style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 17.sf(context), color: Colors.white),
                                decoration: InputDecoration(
                                    isDense: true,
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    hintText: _appLocalization
                                        .confirm_password_hint_label
                                        .capitalize(),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontSize: 17.sf(context), color: Colors.white.withOpacity(0.3))),
                              ),
                              focusNode: _confirmFocus,
                              borderColor: Colors.white.withOpacity(0.5),
                              label: _appLocalization.confirm_password.toUpperCase(),
                              hintLabel: _appLocalization.confirm_password_hint_label
                                  .capitalize(),
                              labelColor: Colors.white,
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                      BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                        listener: (context, state) async{
                          if (state.stateStatus == StateStatus.failure) {
                            MyApp.failureHandling(context, state.failure!);
                          } else if (state.stateStatus == StateStatus.success) {
                            await addBoolToSF(true);
                              Navigator.of(context).pushReplacementNamed(AppRouteName.changePhoneScreen);
                          }
                        },
                        builder: (context, state) {
                          return BlocBuilder<NotInternetCubit, bool>(
                            builder: (context, internetState) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(onSurface: Colors.white.withOpacity(0.15)),
                                    onPressed: internetState
                                        ? () {
                                      if (state.newPassword.length < 3 || state.confirmPassword.length < 3) {
                                        showErrorFlushBar(context, _appLocalization.error_length_password);
                                      }

                                      else if (state.newPassword != state.confirmPassword) {
                                        showErrorFlushBar(context, _appLocalization.error_different_password);
                                      }

                                      else {   _onChangeCurrentPassword(widget.currentPassword);
                                      context.read<ChangePasswordCubit>().changePassword();
                                      }
                                    }
                                        : null,
                                    child: state.stateStatus == StateStatus.loading
                                        ? CupertinoActivityIndicator(radius: 12)
                                        : Text(_appLocalization.save.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
  addBoolToSF(bool a) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', a);
  }



  void _onChangeCurrentPassword(String changedText) {
    context.read<ChangePasswordCubit>().onChangeCurrentPassword(changedText);
  }
void _onChangeNewCurrentPassword(String changedText) {
    context.read<ChangePasswordCubit>().onChangeNewPassword(changedText);
  }

  void _onChangeConfirmCurrentPassword(String changedText) {
    context.read<ChangePasswordCubit>().onChangeConfirmPassword(changedText);
  }

  _initAppBarWithLanguage() {
    return SizedBox(
      height: 180,
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
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SvgPicture.asset('assets/icons/lock_icon.svg')

      ),
          Positioned(top: 0, right: 0, child: LanguageComponent())
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
