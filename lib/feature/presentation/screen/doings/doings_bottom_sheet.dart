import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DoingsBottomSheet extends StatefulWidget {
  const DoingsBottomSheet({Key? key}) : super(key: key);

  @override
  State<DoingsBottomSheet> createState() => _DoingsBottomSheetState();
}

class _DoingsBottomSheetState extends State<DoingsBottomSheet> {
  late AppLocalizations _appLocalization;

  DateTime? chosenDate;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColor.c30000,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SizedBox(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context) * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                  AppDimension.verticalSize_16,
                  SizedBox(width: 64, height: 64, child: SvgPicture.asset('assets/icons/gym.svg')),
                  AppDimension.verticalSize_16,
                  Text(
                    _appLocalization.fitness_club,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white, fontSize: 24.sf(context)),
                  ),
                  AppDimension.verticalSize_24,
                  Text(
                    _appLocalization.fitness_label,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white, fontSize: 14.sf(context)),
                    textAlign: TextAlign.center,
                  ),
                  AppDimension.verticalSize_24,
                  _initRangeDate(),
                  AppDimension.verticalSize_24,
                  _initTextField(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(_appLocalization.make_reservation.capitalize(),style: TextStyle(fontSize: 14.sf(context))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _openToDateTimePicker() {
    return showDatePicker(
      context: context,
      initialDate: chosenDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
      initialDatePickerMode: DatePickerMode.day,
    ).then((value) {
      if (value != null) {
        setState(() {
          chosenDate = value;
        });
      }
      return null;
    });
  }

  Widget _initRangeDate() {
    return InkWell(
      onTap: () {
        _openToDateTimePicker();
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _appLocalization.date_and_time.capitalize(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 12.sf(context),
                  ),
            ),
            AppDimension.verticalSize_8,
            Row(
              children: [
                Text(
                  chosenDate?.formatDateTime() ?? _appLocalization.select_date_reservation.capitalize(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white.withOpacity(0.3),
                        fontSize: 17.sf(context),
                      ),
                ),
                AppDimension.horizontalSize_8,
                const Spacer(),
                SvgPicture.asset('assets/icons/calendar_range.svg')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _initTextField() {
    return Container(
      height: 144,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _appLocalization.wish.capitalize(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 12.sf(context),
                ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 17.sf(context),
                ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _appLocalization.write_your_wish.capitalize(),
                hintStyle: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white.withOpacity(0.3), fontSize: 17.sf(context))),
          )
        ],
      ),
    );
  }
}
