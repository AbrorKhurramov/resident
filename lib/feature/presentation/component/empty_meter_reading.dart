import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';

class EmptyMeterReading extends StatefulWidget {
  final CommunalType communalType;

  const EmptyMeterReading({Key? key, required this.communalType})
      : super(key: key);

  @override
  State<EmptyMeterReading> createState() => _EmptyMeterReadingState();
}

class _EmptyMeterReadingState extends State<EmptyMeterReading> {
  late AppLocalizations _appLocalization;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white.withOpacity(0.95)),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _initCommunalTypeHeader(),
          AppDimension.verticalSize_20,
          _initAddButton(),
          AppDimension.verticalSize_20,
          Text(
            _appLocalization.enter_counter_indication.capitalize(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Colors.black, fontSize: 11.sf(context)),
          )
        ],
      ),
    );
  }

  Widget _initCommunalTypeHeader() {
    String iconPath = _getIconPath(widget.communalType);

    String label = _getLabel(widget.communalType);

    String descriptionLabel = _getDescription(widget.communalType);

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
                    : SizedBox()
              ],
            )
          ],
        ),
      ],
    );
  }

  String _getIconPath(CommunalType communalType) {
    switch (communalType) {
      case CommunalType.coldWater:
        return 'assets/icons/cold_water.svg';
      case CommunalType.hotWater:
        return 'assets/icons/hot_water.svg';
      case CommunalType.electricity:
        return 'assets/icons/light.svg';
      case CommunalType.gas:
        return 'assets/icons/gas.svg';
        case CommunalType.other:
        return 'assets/icons/other.svg';
      default:
        return 'assets/icons/hot_water.svg';
    }
  }

  String _getLabel(CommunalType communalType) {
    switch (communalType) {
      case CommunalType.coldWater:
        return _appLocalization.cold_water;
      case CommunalType.hotWater:
        return _appLocalization.hot_water;
        case CommunalType.gas:
        return _appLocalization.gas;
      case CommunalType.electricity:
        return _appLocalization.electricity;
      default:
        return _appLocalization.electricity;
    }
  }

  String _getDescription(CommunalType communalType) {
    if (communalType == CommunalType.electricity) {
      return _appLocalization.electricity_description;
    }
    return '';
  }

  Widget _initAddButton() {
    return Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.c6000,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ));
  }
}
