import 'dart:async';
import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/app_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/my_card/component/confirmation_card_bottom_sheet.dart';
import 'package:resident/injection/injection_container.dart';
import 'package:resident/main.dart';
import 'package:pinput/pinput.dart';

class AddCardBottomSheet extends StatefulWidget {
   AddCardBottomSheet({Key? key,required this.subContext}) : super(key: key);
BuildContext subContext;
  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  late StreamSubscription listener;

  late AppLocalizations _appLocalization;
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _cardExpiryDate = TextEditingController();
  final SmartAuth smartAuth = SmartAuth();
  final FocusNode _cardNumberFocusNode = FocusNode();
  final FocusNode _cardExpiryDateFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
  // getSmsCode();
  }

  @override
  void dispose() {
    super.dispose();
    _cardNumber.dispose();
    _cardExpiryDate.dispose();
  }
  void getSmsCode() async {

    await Future.delayed(const Duration(seconds: 10));

    debugPrint('Begin');
    final res = await smartAuth.getSmsCode(useUserConsentApi: false);
    if (res.succeed) {
      debugPrint('SMS: ${res.code}');
    } else {
      debugPrint('SMS Failure:'+res.toString());
    }
    debugPrint(res.toString());
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
              child: BlocConsumer<AddCardCubit, AddCardState>(
                  listener: (context, state) {
                if (state.stateStatus == StateStatus.success) {
print("SUCCESS");
            //    getSmsCode();

                  _openConfirmationBottomSheet(state.response!.data!);
                } else if (state.stateStatus == StateStatus.failure) {
                  MyApp.failureHandling(context, state.failure!);
                }
              }, builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                          'assets/icons/modal_bottom_top_line.svg'),
                      AppDimension.verticalSize_16,
                      Text(
                        _appLocalization.add_card.capitalize(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                      ),
                      AppDimension.verticalSize_24,
                      AppTextField(
                        textFormField: TextFormField(
                          controller: _cardNumber,
                          focusNode: _cardNumberFocusNode,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .requestFocus(_cardExpiryDateFocusNode);
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskedInputFormatter('#### #### #### ####'),
                          ],
                          maxLength: 19,
                          textInputAction: TextInputAction.next,
                          onChanged: _onChangeCardNumber,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 17.sf(context), color: AppColor.c9000),
                          decoration: InputDecoration(
                              isDense: true,
                              counterText: "",
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: "0000 0000 0000 0000",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize: 17.sf(context), color: AppColor.c9000)),
                        ),
                        focusNode: _cardNumberFocusNode,
                        borderColor: AppColor.c8000,
                        label: _appLocalization.card_number.capitalize(),
                        hintLabel: '0000 0000 0000 0000',
                        labelColor: AppColor.c4000,
                      ),
                      AppDimension.verticalSize_24,
                      AppTextField(
                        textFormField: TextFormField(
                          controller: _cardExpiryDate,
                          focusNode: _cardExpiryDateFocusNode,
                          maxLength: 5,
                          onFieldSubmitted: (v) {
                            FocusScope.of(context)
                                .unfocus();
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            CreditCardExpirationDateFormatter()
                          ],
                          textInputAction: TextInputAction.done,
                          onChanged: _onChangeExpiryDate,
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(fontSize: 17.sf(context), color: AppColor.c9000),
                          decoration: InputDecoration(
                              isDense: true,
                              counterText: "",
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: '00/00',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      fontSize: 17.sf(context), color: AppColor.c9000)),
                        ),
                        focusNode: _cardExpiryDateFocusNode,
                        borderColor: AppColor.c8000,
                        label: _appLocalization.card_expiry_date.capitalize(),
                        hintLabel: "00/00",
                        labelColor: AppColor.c4000,
                      ),
                      AppDimension.verticalSize_24,
                      const Spacer(),
                      BlocBuilder<NotInternetCubit, bool>(
                          builder: (context, internetState) {
                        return BlocBuilder<AddCardCubit, AddCardState>(
                          builder: (context, addCardState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 36),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      onSurface:
                                          AppColor.c6000.withOpacity(0.15),
                                      primary: AppColor.c6000),
                                  onPressed: _validate(state.cardNumber,
                                              state.expiryDate) &&
                                          internetState
                                      ? _onAddCard
                                      : null,
                                  child: state.stateStatus ==
                                          StateStatus.loading
                                      ? const CupertinoActivityIndicator(radius: 12)
                                      : Text(
                                          _appLocalization.add.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                            );
                          },
                        );
                      })
                    ],
                  ),
                );
              }),
            ),
          )),
    );
  }

  bool _validate(cardNumber, expiryDate) {
    if (cardNumber != 19 || expiryDate != 5) {
      return true;
    }

    return true;
  }

  void _onAddCard() {
    context.read<AddCardCubit>().onAddCard();
  }

  void _onChangeCardNumber(String changedText) {
    context.read<AddCardCubit>().onChangeCardNumber(changedText);
  }

  void _onChangeExpiryDate(String changedText) {
    context.read<AddCardCubit>().onChangeExpiryDate(changedText);
  }

  void _openConfirmationBottomSheet(SmsCardResponse smsCardResponse) {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (_) => getIt<ConfirmationCardCubit>(),
            child:
                ConfirmationCardBottomSheet(smsCardResponse: smsCardResponse,subContext: widget.subContext),
          );
        }).then((value) => Navigator.pop(context, value));
  }
}
