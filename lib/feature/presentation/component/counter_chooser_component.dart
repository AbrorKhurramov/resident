import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

class CounterChooserComponent extends StatefulWidget {
  final List<Counter> counters;
  final Function(Counter) onPressed;

  const CounterChooserComponent({
    Key? key,
    required this.counters,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CounterChooserComponent> createState() =>
      _CounterChooserComponentState();
}

class _CounterChooserComponentState extends State<CounterChooserComponent> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    var items = widget.counters.map((item) {
      return DropdownMenuItem<Counter>(
        value: item,
        child: Text(
          _getCounterLabel(item),
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 17, color: Colors.black),
        ),
      );
    }).toList();
    return widget.counters.length > 1
        ? Container(
            width: AppConfig.screenWidth(context),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: AppColor.c6000,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _appLocalization.counter.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.white, fontSize: 12),
                ),
                BlocBuilder<CreateInvoiceCubit, CreateInvoiceState>(
                    builder: (context, state) {
                  return DropdownButton<Counter>(
                      value: state.counter,
                      items: items,
                      iconEnabledColor: Colors.white,
                      iconDisabledColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      underline: SizedBox(),
                      isExpanded: true,
                      selectedItemBuilder: (BuildContext ctx) {
                        return items.map<Widget>((item) {
                          return DropdownMenuItem(
                              value: item.value,
                              child: Text(
                                "${item.value}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        fontSize: 17, color: Colors.white),
                              ));
                        }).toList();
                      },
                      onChanged: (chosenCounter) {
                        if (chosenCounter != null) {
                          context
                              .read<CreateInvoiceCubit>()
                              .chooseCounter(chosenCounter);
                        }
                      });
                })
              ],
            ),
          )
        : SizedBox();
  }

  String _getCounterLabel(Counter counter) {
    if (counter.counterName != null) {
      return counter.counterName!;
    } else if (counter.counterNumber != null) {
      return counter.counterNumber!;
    }

    return '';
  }
}
