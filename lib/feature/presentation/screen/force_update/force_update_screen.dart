


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:new_version/new_version.dart';


class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations  appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
          width: AppConfig.screenWidth(context),
          height: AppConfig.screenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/splash_bg.png',
                ),
                fit: BoxFit.fill),
          ),
        child: Column(
          children: [
            AppDimension.verticalSize_64,
            AppDimension.verticalSize_64,
            AppDimension.verticalSize_32,
            Center(
              child: SvgPicture.asset('assets/icons/no_internet.svg'),
            ),
            AppDimension.verticalSize_64,
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90),
                child: Text(appLocalization.install_software_update.capitalize(),style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(disabledForegroundColor: Colors.white.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: Colors.white.withOpacity(0.15).withOpacity(0.12)),
                  onPressed: () async{
                    var versionStatus = await NewVersion().getVersionStatus();
                    NewVersion().launchAppStore(versionStatus!.appStoreLink);
                  },
                  child: Text(appLocalization.install_update.capitalize(),style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14.sf(context),color: Colors.white),)),
            ),
            AppDimension.verticalSize_32,
          ],
        ),
      ),
    );
  }
}
