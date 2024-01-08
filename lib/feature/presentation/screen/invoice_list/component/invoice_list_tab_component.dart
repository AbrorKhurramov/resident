import 'package:resident/core/extension/size_extension.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceListTabItem extends Equatable {
  final int monthIndex;
  final int year;
  final bool active;

  const InvoiceListTabItem(
      {required this.monthIndex, required this.year, required this.active});

  InvoiceListTabItem copyWith({int? monthIndex, int? year, bool? active}) {
    return InvoiceListTabItem(
        monthIndex: monthIndex ?? this.monthIndex,
        year: year ?? this.year,
        active: active ?? this.active);
  }

  @override
  List<Object?> get props => [monthIndex, year, active];
}

class InvoiceListTabComponent extends StatefulWidget {
  final int monthIndex;
  final int year;
  final bool active;

  const InvoiceListTabComponent(
      {Key? key,
      required this.monthIndex,
      required this.year,
      required this.active})
      : super(key: key);

  @override
  State<InvoiceListTabComponent> createState() =>
      _InvoiceTabListComponentState();
}

class _InvoiceTabListComponentState extends State<InvoiceListTabComponent> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      FittedBox( child: Text(
          getMonthLabel(widget.monthIndex),
          style: widget.active
              ? Theme.of(context).textTheme.headline2!.copyWith(
                    color: Colors.black,
                    fontSize: 16.sf(context),
                  )
              : Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 15.sf(context),
                  ),
        )),
        _initYear()
      ],
    );
  }

  Widget _initYear() {
    DateTime now = DateTime.now();
    if (widget.active) {
      return Container(
        margin: const EdgeInsets.all(4),
        width: 8,
        height: 8,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: AppColor.c6000),
      );
    } else {
      return Text(widget.year.toString(),
          style: Theme.of(context).textTheme.headline2!.copyWith(
                color: Colors.black.withOpacity(0.3),
                fontSize: 16.sf(context),
              ));
    }
    return AppDimension.defaultSize;
  }

  String getMonthLabel(int monthIndex) {
    switch (monthIndex) {
      case 1:
        return _appLocalization.january;
      case 2:
        return _appLocalization.february;
      case 3:
        return _appLocalization.march;
      case 4:
        return _appLocalization.april;
      case 5:
        return _appLocalization.may;
      case 6:
        return _appLocalization.june;
      case 7:
        return _appLocalization.july;
      case 8:
        return _appLocalization.august;
      case 9:
        return _appLocalization.september;
      case 10:
        return _appLocalization.october;
      case 11:
        return _appLocalization.november;
      default:
        return _appLocalization.december;
    }
  }
}
