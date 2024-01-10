import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/main.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  late StreamSubscription listener;

  late AppLocalizations _appLocalization;
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FocusNode _currentFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _currentController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context) * 0.9,
            child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
              if (state.stateStatus == StateStatus.failure) {
                MyApp.failureHandling(context, state.failure!);
              } else if (state.stateStatus == StateStatus.success) {
                Navigator.of(context).pop();
                showSuccessFlushBar(
                    context,
                    state.response?.statusMessage.translate(
                            context.read<LanguageCubit>().state.languageCode) ??
                        '');
              }
            }, builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                    AppDimension.verticalSize_16,
                    Text(
                      _appLocalization.change_password.capitalize(),
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                    ),
                    AppDimension.verticalSize_24,
                    AppTextField(
                      textFormField: TextFormField(
                        controller: _currentController,
                        focusNode: _currentFocus,
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(_newPasswordFocus);
                        },
                        maxLength: 32,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        onChanged: _onChangeCurrentPassword,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 14.sf(context), color: AppColor.c9000),
                        decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: _appLocalization
                                .current_password_hint_label
                                .capitalize(),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 17.sf(context), color: AppColor.c9000)),
                      ),
                      focusNode: _currentFocus,
                      borderColor: AppColor.c8000,
                      label: _appLocalization.current_password.toUpperCase(),
                      hintLabel: _appLocalization.current_password_hint_label
                          .capitalize(),
                      labelColor: AppColor.c4000,
                    ),
                    AppDimension.verticalSize_24,
                    AppTextField(
                      textFormField: TextFormField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocus,
                        onFieldSubmitted: (v){
                          FocusScope.of(context).requestFocus(_confirmFocus);
                        },
                        maxLength: 32,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        onChanged: _onChangeNewCurrentPassword,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 14.sf(context), color: AppColor.c9000),
                        decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: _appLocalization.new_password_hint_label
                                .capitalize(),
                            hintStyle: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 17.sf(context), color: AppColor.c9000)),
                      ),
                      focusNode: _newPasswordFocus,
                      borderColor: AppColor.c8000,
                      label: _appLocalization.new_password.toUpperCase(),
                      hintLabel:
                          _appLocalization.new_password_hint_label.capitalize(),
                      labelColor: AppColor.c4000,
                    ),
                    AppDimension.verticalSize_24,
                    AppTextField(
                      textFormField: TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmFocus,
                        maxLength: 32,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onChanged: _onChangeConfirmCurrentPassword,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 14.sf(context), color: AppColor.c9000),
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
                                .headlineMedium!
                                .copyWith(fontSize: 17.sf(context), color: AppColor.c9000)),
                      ),
                      focusNode: _confirmFocus,
                      borderColor: AppColor.c8000,
                      label: _appLocalization.confirm_password.toUpperCase(),
                      hintLabel: _appLocalization.confirm_password_hint_label
                          .capitalize(),
                      labelColor: AppColor.c4000,
                    ),
                    const Spacer(),
                    BlocBuilder<NotInternetCubit, bool>(
                      builder: (context, internetState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 36),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.c6000, disabledForegroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.12)),
                              onPressed: _validate(
                                          state.currentPassword,
                                          state.newPassword,
                                          state.confirmPassword) &&
                                      internetState
                                  ? _changePassword
                                  : null,
                              child: state.stateStatus == StateStatus.loading
                                  ? const CupertinoActivityIndicator(radius: 12)
                                  : Text(_appLocalization.save.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                        );
                      },
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  bool _validate(String currentPassword, newPassword, confirmPassword) {
    if (currentPassword.length < 3 || newPassword.length < 3) {
      return false;
    }

    if (newPassword != confirmPassword) {
      return false;
    }

    return true;
  }

  void _changePassword() {
    context.read<ChangePasswordCubit>().changePassword();
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
}
