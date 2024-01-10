import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/invoice_status_component.dart';
import 'package:provider/src/provider.dart';

class InvoiceCardComponent extends StatefulWidget {
  final Invoice invoice;

  const InvoiceCardComponent({Key? key, required this.invoice}) : super(key: key);

  @override
  State<InvoiceCardComponent> createState() => _InvoiceCardComponentState();
}

class _InvoiceCardComponentState extends State<InvoiceCardComponent> {
  late final AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.invoice.invoiceService.isNotEmpty)  _initItemHeader(widget.invoice.invoiceService[0]),
          AppDimension.verticalSize_16,
          Text(
            '${widget.invoice.amount?.currencyFormat() ?? ''} ${_appLocalization.sum}',
            style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 28.sf(context), color: AppColor.c4000),
          ),
          InvoiceStatusComponent(invoice: widget.invoice),
          AppDimension.verticalSize_12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _initInfo(
                context.read<AppCubit>().state.user!.getActiveApartment().complex!.name,
                '${context.read<AppCubit>().state.user!.getActiveApartment().bloc!.name.translate(context.read<LanguageCubit>().state.languageCode)}, ${context.read<AppCubit>().state.user!.getActiveApartment().type==1?_appLocalization.flat.capitalize():_appLocalization.office.capitalize()} ${context.read<AppCubit>().state.user!.getActiveApartment().numberApartment}',
                TextAlign.left,
              ),
              _initNumberAndDate(widget.invoice),
            ],
          ),
          AppDimension.verticalSize_16,
          const Divider(thickness: 1),
          AppDimension.verticalSize_16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_appLocalization.invoice_number}:',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
              ),
              Text(widget.invoice.invoice.toString(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColor.c4000, fontSize: 13.sf(context)))
            ],
          ),
          AppDimension.verticalSize_16,
          const Divider(thickness: 1),
          AppDimension.verticalSize_16,
          if(widget.invoice.invoiceService.isNotEmpty) _initBottomItem(widget.invoice.invoiceService[0]),
          _initClosedDate(widget.invoice.closedDate)
        ],
      ),
    );
  }

  Widget _initNumberAndDate(Invoice invoice) {
    if (invoice.createdDate == null) {
      return const SizedBox();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          _appLocalization.date_of_issue.capitalize(),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sf(context), color: AppColor.c3000),
        ),
        Text(
    invoice.createdDate!.getDateWithHour(_appLocalization),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sf(context), color: AppColor.c4000),
        ),
      ],
    );
  }

  Widget _initItemHeader(InvoiceService? invoiceService) {
    if (invoiceService == null) {
      return AppDimension.defaultSize;
    }

    late String iconPath;
    late String message;

    if (invoiceService.type == null) {
      iconPath = 'assets/icons/cold_water.svg';
      message = _appLocalization.others.capitalize();
    }

    switch (invoiceService.type) {
      case 'COOL_WATER':
        iconPath = 'assets/icons/cold_water.svg';
        message = _appLocalization.cold_water.capitalize();
        break;
      case 'HOT_WATER':
        iconPath = 'assets/icons/hot_water.svg';
        message = _appLocalization.hot_water.capitalize();
        break;
      case 'ELECTRICITY':
        iconPath = 'assets/icons/light.svg';
        message = _appLocalization.electricity.capitalize();
        break;
      case 'GAS':
        iconPath = 'assets/icons/gas.svg';
        message = _appLocalization.gas.capitalize();
        break;
      default:
        iconPath = 'assets/icons/others.svg';
        message = _appLocalization.others.capitalize();
        break;
    }

    return Row(
      children: [
        SvgPicture.asset(iconPath),
        AppDimension.horizontalSize_8,
        Text(
          message,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
        ),
      ],
    );
  }
 Widget _initBottomItem(InvoiceService? invoiceService) {
    if (invoiceService == null) {
      return AppDimension.defaultSize;
    }

    late bool isService;


    if (invoiceService.type == null) {
     isService = true;
    }

    switch (invoiceService.type) {
      case 'COOL_WATER':
       isService = false;
        break;
      case 'HOT_WATER':
        isService = false; break;
      case 'ELECTRICITY':
        isService = false;
        break;
      case 'GAS':
        isService = false;break;
      default:
        isService = true;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isService?'${_appLocalization.services.capitalize()}:':'${_appLocalization.indication.capitalize()}:',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: AppColor.c3000,
            fontSize: 13.sf(context),
          ),
        ),
        Text(!isService?widget.invoice.invoiceService.isNotEmpty?  widget.invoice.invoiceService[0].result?.toString() ?? '':"":invoiceService.message
            ?.translate(context.read<LanguageCubit>().languageCode()) ??
            "".capitalize(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: AppColor.c4000,
              fontSize: 13.sf(context),
            ))
      ],
    );
  }

  Widget _initInfo(String title, String description, TextAlign textAlign) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sf(context), color: AppColor.c3000),
        ),
        Text(
          description,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sf(context), color: AppColor.c4000),
        ),
      ],
    );
  }

  Widget _initClosedDate(String? closedDate) {
    if (closedDate == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        AppDimension.verticalSize_16,
        const Divider(thickness: 1),
        AppDimension.verticalSize_16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _appLocalization.payment_date.capitalize(),
              style: Theme.of(context).textTheme.displaySmall!.copyWith(color: AppColor.c3000, fontSize: 13.sf(context)),
            ),
            Text(
               // '${closedDateTime.getDay()} ${closedDateTime.getMonthLabel(_appLocalization)} ${closedDateTime.year}, ${closedDate.getHourAndMinute()}',
                closedDate.getDateWithHour(_appLocalization),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColor.c4000, fontSize: 13.sf(context)))
          ],
        )
      ],
    );
  }
}
