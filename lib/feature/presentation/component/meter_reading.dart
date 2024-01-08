import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/status_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeterReading extends StatefulWidget {
  final CommunalType communalType;
  final List<Counter> counters;
  final void Function()? onTapAddOther;

  const MeterReading({
    Key? key,
    required this.communalType,
    required this.counters,
    this.onTapAddOther
  }) : super(key: key);

  @override
  State<MeterReading> createState() => _MeterReadingState();
}

class _MeterReadingState extends State<MeterReading> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;
  int allBalance = 0;
  bool monthlyStatus = false;
  bool invoiceStatus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateBalance();
    _invoiceStatus();
  }


  void _invoiceStatus(){
    for (Counter counter in widget.counters) {
      if (counter.invoiceStatus) {
        invoiceStatus = true;
        return;
      }
    }
  }

  void _calculateBalance() {
    for (Counter counter in widget.counters) {
      allBalance += counter.balance;
    }
    for (Counter counter in widget.counters) {
      if (counter.status) {
        monthlyStatus = true;
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: Colors.white.withOpacity(0.95)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _initCommunalTypeHeader(),
           _initStatusComponent(),
          AppDimension.verticalSize_16,
          _initBalanceMeters(),
          AppDimension.verticalSize_16,
          widget.counters.isNotEmpty
              ? _initCounterAndMeter()
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _initStatusComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: monthlyStatus,
          child: Padding(padding: const EdgeInsets.only(top: 8),
            child: StatusComponent(
              label: _appLocalization.update_counter,
              color:  AppColor.c70000,
            ),
          ),
        ),
        Visibility(
          visible: invoiceStatus,
          child: Padding(padding: const EdgeInsets.only(top: 8),
            child: StatusComponent(
              label:  _appLocalization.outstanding_debt,
              color:  AppColor.c6000,
            ),
          ),
        ),
      ],
    );
  }

  Widget _initBalanceMeters() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         // allBalance >= 0
          //  ? _appLocalization.balance.capitalize()
          //  :
          _appLocalization.amount_debt.capitalize(),
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 10.sf(context),
                color: AppColor.c3000,
              ),
        ),
        Text(
          '${allBalance>0?"-":""} ${allBalance.currencyFormat()} ${_appLocalization.sum}',
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 28.sf(context),
                color: AppColor.c4000,
              ),
        )
      ],
    );
  }

  Widget _initCounterAndMeter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _appLocalization.counter.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppColor.c3000, fontSize: 10.sf(context)),
            ),
            Text(
              _appLocalization.indication.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppColor.c3000, fontSize: 10.sf(context)),
            )
          ],
        ),
        Column(
          children: widget.counters
              .map((counter) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          counter.counterName == null
                              ? counter.counterNumber?.toString() ?? ''
                              : counter.counterName?.toString() ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
                        ),
                        Text(
                          counter.serviceResult?.toString().capitalize() ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
                        )
                      ]))
              .toList(),
        )
      ],
    );
  }

  Widget _initCommunalTypeHeader() {
    String iconPath = widget.communalType.getIconPath();

    String label = widget.communalType.getLabel(_appLocalization);

    String descriptionLabel = widget.communalType.getDescription(_appLocalization);

    bool isOthers = widget.communalType==CommunalType.other;

    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(iconPath),
            AppDimension.horizontalSize_8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontSize: 10.sf(context), color: AppColor.c4000),
                ),
                descriptionLabel.isNotEmpty
                    ? Text(
                        descriptionLabel.capitalize(),
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(fontSize: 10.sf(context), color: AppColor.c3000),
                      )
                    : const SizedBox()
              ],
            ),
            const Spacer(),
            Visibility(
                visible: isOthers,
                child: InkWell(
                  onTap: widget.onTapAddOther,
                  highlightColor: AppColor.transparent,
                  splashColor: AppColor.transparent,
                  hoverColor: AppColor.transparent,
                  child: const Row(
                    children: [
                      AppDimension.horizontalSize_8,
                      Icon(Icons.add),
                      AppDimension.horizontalSize_4,
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
