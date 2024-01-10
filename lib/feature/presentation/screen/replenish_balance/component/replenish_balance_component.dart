import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/app_text_field.dart';
import 'package:resident/feature/presentation/component/card_component.dart';
import 'package:resident/feature/presentation/screen/replenish_balance/component/replenish_details_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/replenish_balance/component/replenish_flat_card.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/extension/thousands_input_formatter.dart';
import '../../../../../injection/injection_container.dart';

class ReplenishBalanceComponent extends StatefulWidget {
  const ReplenishBalanceComponent({Key? key}) : super(key: key);

  @override
  State<ReplenishBalanceComponent> createState() =>
      _ReplenishBalanceComponentState();
}

class _ReplenishBalanceComponentState extends State<ReplenishBalanceComponent> {
  late AppLocalizations _appLocalization;
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AppDimension.verticalSize_12,
          ReplenishFlatCard(
              apartment:
                  context.read<AppCubit>().state.user!.getActiveApartment()),
          AppDimension.verticalSize_16,
          _initAmountTextField(),
          AppDimension.verticalSize_32,
          BlocBuilder<CardCubit, CardState>(builder: (context, cardState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _appLocalization.payment_method.capitalize(),
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: AppColor.c4000, fontSize: 15),
                ),
                AppDimension.verticalSize_8,
                CardComponent(cardResponse: cardState.response!.data[0])
              ],
            );
          }),
          AppDimension.verticalSize_32,
            BlocConsumer<ReplenishmentDetailsCubit, ReplenishmentDetailsState>(
            listener: (context, replenishmentDetailsState) {
              if (replenishmentDetailsState.stateStatus == StateStatus.success) {
              } else if (replenishmentDetailsState.stateStatus ==
                  StateStatus.failure) {
                MyApp.failureHandling(context, replenishmentDetailsState.failure!);
              }
            },
            builder: (context, replenishmentState) {
              return ElevatedButton(
                onPressed: () {
                  if (_amountController.text.isNotEmpty) {
                    _openReplenishmentDetailsBottomSheet(replenishmentState.response!.data!,int.parse(_amountController.text.replaceAll(" ", "")),context.read<CardCubit>().state.response!.data[0].id!);
                  _amountController.clear();
                  }
                },
                child: replenishmentState.stateStatus == StateStatus.loading
                    ? const CupertinoActivityIndicator(radius: 12)
                    : Text(_appLocalization.top_up.toUpperCase(),style: TextStyle(fontSize: 14.sf(context))),
              );
            },
          ),

          AppDimension.verticalSize_16,
        ],
      ),
    );
  }

  Widget _initAmountTextField() {
    return AppTextField(
      textFormField: TextFormField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        focusNode: _amountFocusNode,
        inputFormatters: [
          ThousandsSeparatorInputFormatter(),
        ],
        maxLength: 19,
        textInputAction: TextInputAction.done,
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontSize: 17, color: AppColor.c9000),
        decoration: InputDecoration(
            isDense: true,
            counterText: "",
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: "0 ${_appLocalization.sum}",
            hintStyle: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 17, color: AppColor.c9000)),
      ),
      focusNode: _amountFocusNode,
      backgroundColor: Colors.white,
      borderColor: AppColor.c8000,
      label: _appLocalization.top_up_amount.toUpperCase(),
      hintLabel: '0 ${_appLocalization.sum}',
      labelColor: AppColor.c4000,
    );
  }


_openReplenishmentDetailsBottomSheet(ReplenishmentDetailsResponse response,int amount,String cardId){
  showAppModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
                create: (context) => getIt<ReplenishmentCubit>(),
  child: ReplenishDetailsBottomSheet(
          amount: amount,
        replenishmentDetails: response,
    cardId: cardId,
               ),
);
      // }).then((value) {

  });
}



}
