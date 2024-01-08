import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';

import '../../../../../main.dart';
import '../../../bloc/app_cubit/app_cubit.dart';
import '../../../bloc/language_cubit/language_cubit.dart';
import '../../../bloc/profile_cubit/profile_cubit.dart';
import '../../../bloc/replenishment_cubit/replenishment_cubit.dart';
import '../../../bloc/replenishment_cubit/replenishment_state.dart';
import '../../../component/app_modal_bottom_sheet.dart';
import '../../../component/succesfull_bottom_sheet.dart';

class ReplenishDetailsBottomSheet extends StatefulWidget {
  final ReplenishmentDetailsResponse replenishmentDetails;
  final int amount;
  final String cardId;

  const ReplenishDetailsBottomSheet({required this.replenishmentDetails,required this.amount,required this.cardId, Key? key}) : super(key: key);

  @override
  State<ReplenishDetailsBottomSheet> createState() => _ReplenishDetailsBottomSheetState();
}

class _ReplenishDetailsBottomSheetState extends State<ReplenishDetailsBottomSheet> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
          AppDimension.verticalSize_16,
          Text(
            _appLocalization.detailing.capitalize(),
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
          ),
          const SizedBox(height: 40),
          _initRowItem(
              _appLocalization.flat_info.capitalize(),
              widget.replenishmentDetails.replenishmentBloc.complex!.name
          ),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem("${_appLocalization.address.capitalize()}:","${widget.replenishmentDetails.replenishmentBloc.name.translate(context.read<LanguageCubit>().state.languageCode)}, ${_appLocalization.flat} ${widget.replenishmentDetails.replenishmentApartment.numberApartment}"
              ),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem("${_appLocalization.personal_account.capitalize()}:",
              widget.replenishmentDetails.replenishmentApartment.prefixNumber),
          const Divider(thickness: 1, color: AppColor.c40000),
            _initRowItem("${_appLocalization.commission.capitalize()}:",
              (widget.replenishmentDetails.fee*widget.amount/100).toString() + _appLocalization.sum),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem('${_appLocalization.top_up_amount.capitalize()}:',
              '${(widget.amount*100).toInt().currencyFormat()} ${_appLocalization.sum}'),
          const Divider(thickness: 1, color: AppColor.c40000),
          AppDimension.verticalSize_20,
          Text("${_appLocalization.total_amount.capitalize()}:",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14.sf(context))),
          AppDimension.verticalSize_8,
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: AppColor.c7000,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(
              "${(widget.amount*(100+widget.replenishmentDetails.fee)).toInt().currencyFormat()} ${_appLocalization.sum}",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 20.sf(context), color: Colors.white),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: AppColor.c60000, onPrimary: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(_appLocalization.cancel.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)),)),
              ),
              AppDimension.horizontalSize_8,
              Expanded(
                child: BlocConsumer<ReplenishmentCubit, ReplenishmentState>(
  listener: (context, replenishmentState) {
    if (replenishmentState.stateStatus == StateStatus.success) {
          _openSuccessBottomSheet();
        } else if (replenishmentState.stateStatus ==
            StateStatus.failure) {
          MyApp.failureHandling(context, replenishmentState.failure!);
        }
  },
  builder: (context, replenishmentState) {
    return ElevatedButton(
                    onPressed: () {
                      replenishmentState.stateStatus!=StateStatus.loading?  context.read<ReplenishmentCubit>().replenishmentBalance(
                                        widget.cardId,
                                        context
                                            .read<AppCubit>()
                                            .getActiveApartment()
                                            .account!,
                                        widget.amount):null;

                    },
                    child:replenishmentState.stateStatus == StateStatus.loading
                        ? const CupertinoActivityIndicator(radius: 12)
                        :  Text(_appLocalization.top_up.toUpperCase(),style: TextStyle(fontSize: 14.sf(context))));
  },
),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _initRowItem(String label, String desc) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
          ),
          const Spacer(),
          Text(
            desc,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: AppColor.c4000, fontSize: 13.sf(context)),
          ),
        ],
      ),
    );
  }

  _openSuccessBottomSheet() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return SuccessfulBottomSheet(
            description: _appLocalization.balance_replenished_successfully,
            isAdd: 0,
            subContext: context,
          );
        }).then((value) async{
      await  context.read<ProfileCubit>().getProfile();
      Navigator.pop(context, true);
    });
  }
}
