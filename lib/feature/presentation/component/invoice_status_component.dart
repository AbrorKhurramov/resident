import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';

class InvoiceStatusComponent extends StatefulWidget {
  final Invoice invoice;

  const InvoiceStatusComponent({Key? key, required this.invoice}) : super(key: key);

  @override
  State<InvoiceStatusComponent> createState() => _InvoiceStatusComponentState();
}

class _InvoiceStatusComponentState extends State<InvoiceStatusComponent> {
  late final AppLocalizations _appLocalization ;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {

    String status;
    Color color;

    if (widget.invoice.invoiceStatus!.toLowerCase() == 'open') {
      status = _appLocalization.awaiting_payment;
      color = AppColor.c70000;
    } else if (widget.invoice.invoiceStatus!.toLowerCase() == 'closed') {
      status = _appLocalization.paid;
      color = AppColor.c7000;
    } else {
      status = _appLocalization.canceled;
      color = AppColor.c50000;
    }

    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: color),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 10.sf(context), color: Colors.white),
      ),
    );
  }
}
