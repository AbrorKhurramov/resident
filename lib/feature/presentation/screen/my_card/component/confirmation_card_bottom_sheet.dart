import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/component/succesfull_bottom_sheet.dart';
import 'package:pinput/pinput.dart';

class ConfirmationCardBottomSheet extends StatefulWidget {
  final SmsCardResponse smsCardResponse;
   BuildContext subContext;
   ConfirmationCardBottomSheet({Key? key, required this.smsCardResponse,required this.subContext}) : super(key: key);

  @override
  State<ConfirmationCardBottomSheet> createState() => _ConfirmationCardBottomSheetState();
}

class _ConfirmationCardBottomSheetState extends State<ConfirmationCardBottomSheet> {
  late AppLocalizations _appLocalization;

  final FocusNode firstFocus = FocusNode();
  final FocusNode secondFocus = FocusNode();
  final FocusNode thirdFocus = FocusNode();
  final FocusNode fourthFocus = FocusNode();
  final FocusNode fiveFocus = FocusNode();
  final FocusNode sixFocus = FocusNode();
bool isFocus = true;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    if(isFocus) {
      print("FOCUS");
      FocusScope.of(context).requestFocus(firstFocus);
      isFocus = false;
    }
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
            child: BlocConsumer<ConfirmationCardCubit, ConfirmationCardState>(listener: (context, state) {
              if (state.stateStatus == StateStatus.failure && state.failure != null) {
                showErrorFlushBar(context, (state.failure as ServerFailure).message!.translate(context.read<LanguageCubit>().state.languageCode) ?? '');
              } else if (state.stateStatus == StateStatus.success) {
                _openSuccessBottomSheet();
              }
            }, builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Stack(children: [
                  Positioned(
                    top: 0,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                        AppDimension.verticalSize_16,
                        Text(
                          _appLocalization.confirm_action.capitalize(),
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                        ),
                        AppDimension.verticalSize_32,
                        Text(
                          _appLocalization.sms_number_info(widget.smsCardResponse.phoneNumber != null
                              ? _formatPhoneNumber(widget.smsCardResponse.phoneNumber!)
                              : ''),
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColor.c3000, fontSize: 14.sf(context)),
                          textAlign: TextAlign.center,
                        ),
                        AppDimension.verticalSize_32,
                        Pinput(
                          length: 6,
                          focusNode: firstFocus,
                          androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                          defaultPinTheme: PinTheme(
                            width: 40,
                            height: 48,
                            textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 20.sf(context),
                                  color: AppColor.c4000,
                                ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              color: Colors.white,
                              border: Border.all(
                                color: AppColor.c8000,
                                width: 1,),
                            ),
                          ),
                          onChanged: (changed) {
                            print("CHANGED $changed");
                            if (changed.length == 6) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              return;
                            }
                              context.read<ConfirmationCardCubit>().completeSMSCode(changed);

                          },
                          onCompleted: (pin) {
                            print("PIN $pin");
                            context.read<ConfirmationCardCubit>().completeSMSCode(pin);
                          } ,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     _initTextFormField(TextInputAction.next, 0, firstFocus, secondFocus, firstFocus),
                        //     AppDimension.horizontalSize_8,
                        //     _initTextFormField(TextInputAction.next, 1, secondFocus, thirdFocus, firstFocus),
                        //     AppDimension.horizontalSize_8,
                        //     _initTextFormField(TextInputAction.next, 2, thirdFocus, fourthFocus, secondFocus),
                        //     AppDimension.horizontalSize_8,
                        //     _initTextFormField(TextInputAction.next, 3, fourthFocus, fiveFocus, thirdFocus),
                        //     AppDimension.horizontalSize_8,
                        //     _initTextFormField(TextInputAction.next, 4, fiveFocus, sixFocus, fourthFocus),
                        //     AppDimension.horizontalSize_8,
                        //     _initTextFormField(TextInputAction.done, 5, sixFocus, sixFocus, fiveFocus),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 32,
                      child: BlocBuilder<NotInternetCubit, bool>(
                        builder: (context, internetState) {
                          return BlocBuilder<ConfirmationCardCubit, ConfirmationCardState>(
                            builder: (context, confirmationState) {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.c6000, disabledForegroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.12)),
                                  onPressed: _validate(confirmationState.smsCode) && internetState ? _onConfirm : null,
                                  child: state.stateStatus == StateStatus.loading
                                      ? const CupertinoActivityIndicator(radius: 12)
                                      : Text(_appLocalization.confirm.capitalize(),style: TextStyle(fontSize: 14.sf(context))));
                            },
                          );
                        },
                      ))
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }

  _initTextFormField(TextInputAction textInputAction, int index, FocusNode currentFocusNode, FocusNode nextFocusNode,
      FocusNode prevFocusNode) {
    return Container(
      width: 40,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)), border: Border.all(width: 1, color: AppColor.c8000)),
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          focusNode: currentFocusNode,
          onChanged: (changedText) {
            _onChangeSmsCode(changedText, index);
            if (changedText.isNotEmpty) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
            if (changedText.isEmpty) {
              FocusScope.of(context).requestFocus(prevFocusNode);
            }
          },
          onFieldSubmitted: (v) {
            print(v.toString());
            FocusScope.of(context).requestFocus(nextFocusNode);
          },
          textInputAction: textInputAction,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  _onChangeSmsCode(String newChar, int index) {
    context.read<ConfirmationCardCubit>().changeSmsCard(newChar, index);
  }

  _validate(String smsCode) {
    if (smsCode.length != 6) {
      return false;
    }
    return true;
  }

  _onConfirm() {
    context.read<ConfirmationCardCubit>().confirmation(widget.smsCardResponse,context.read<LanguageCubit>().state.languageCode);
  }

  String _formatPhoneNumber(String phoneNumber) {
    // String formatPhoneNumber = phoneNumber.substring(0, 4) +
    //     ' ' +
    //     phoneNumber.substring(4, 6) +
    //     ' ' +
    //     '***' +
    //     ' ' +
    //     '**' +
    //     ' ' +
    //     phoneNumber.substring(11, 13);

    return phoneNumber;
  }

  _openSuccessBottomSheet() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return SuccessfulBottomSheet(
            description: _appLocalization.card_added_successfully,
            subContext: widget.subContext,
            isAdd: 1,
          );
        }).then((value) {
          print("value$value");
      Navigator.pop(context, value);
    });
  }
}
