import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';


import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventsScreen extends StatelessWidget {

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return const EventsScreen();
    });
  }


  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_third_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomAppBar(label: appLocalization.doings.capitalize()),
                AppDimension.verticalSize_64,
                Container(
                  width: 104,
                  height: 104,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset("assets/icons/empty_calendar.svg"),
                  ),
                ),
                AppDimension.verticalSize_24,
                Text(
                  appLocalization.empty_document,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 15.sf(context), color: AppColor.c3000),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
