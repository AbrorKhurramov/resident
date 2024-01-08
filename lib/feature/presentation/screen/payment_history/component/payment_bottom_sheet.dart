import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

class PaymentBottomSheet extends StatefulWidget {
  final Payment payment;

  const PaymentBottomSheet({required this.payment, Key? key}) : super(key: key);

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
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
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem(
              _appLocalization.flat_info.capitalize(),
              context.read<AppCubit>().getActiveApartment().getApartmentInfo(
                  context.read<LanguageCubit>().languageCode(),
                  _appLocalization.flat)),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem(_appLocalization.transaction_number.capitalize(),
              widget.payment.transactionId ?? ''),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem('${_appLocalization.date_and_time.capitalize()}:',
              widget.payment.createdDate!.getDateWithHour(_appLocalization)),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem('${_appLocalization.payment_method.capitalize()}:',
              widget.payment.cardNumber ?? _appLocalization.offline.capitalize()),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowStatusItem(widget.payment.confirmType!=2,'${_appLocalization.status.capitalize()}:',
              widget.payment.confirmType!=2? _appLocalization.successfully.toUpperCase():_appLocalization.canceled.toUpperCase()),
          const Divider(thickness: 1, color: AppColor.c40000),
          _initRowItem('${_appLocalization.top_up_amount.capitalize()}:',
              '${(widget.payment.amount!/100).toInt().currencyFormat()} ${_appLocalization.sum}'),
          const Divider(thickness: 1, color: AppColor.c40000),
          AppDimension.verticalSize_24,
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(_appLocalization.close.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)),))
        ],
      ),
    );
  }

  Widget _initRowItem(String label, String desc) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
          ),
          SizedBox(
            width: 150,
            child: Text(
              desc,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: AppColor.c4000, fontSize: 13.sf(context)),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _initRowStatusItem(bool isSuccessful,String label, String desc) {
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
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: isSuccessful?AppColor.c7000:AppColor.c50000,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Text(
              desc.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontSize: 12.sf(context), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
