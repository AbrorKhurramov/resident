
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';

class LogOutBottomSheet extends StatefulWidget {
  const LogOutBottomSheet({Key? key}) : super(key: key);

  @override
  State<LogOutBottomSheet> createState() => _LogOutBottomSheetState();
}

class _LogOutBottomSheetState extends State<LogOutBottomSheet> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConfig.screenWidth(context),
      height: AppConfig.screenHeight(context) * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
            const SizedBox(height: 64),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.c6000.withOpacity(0.1),
              ),
              width: 104,
              height: 104,
              child: ClipOval(
                child: SvgPicture.asset('assets/icons/info.svg'),
              ),
            ),
            AppDimension.verticalSize_24,
            Text(
              _appLocalization.log_out_info.toUpperCase(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColor.c4000, fontSize: 14.sf(context)),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.c60000, disabledForegroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.12)),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        _appLocalization.cancel.toUpperCase(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black,fontSize: 14.sf(context)),
                      )),
                ),
                AppDimension.horizontalSize_8,
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.c6000, disabledForegroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: AppColor.c6000.withOpacity(0.15).withOpacity(0.12)),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      child: Text(_appLocalization.exit.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
