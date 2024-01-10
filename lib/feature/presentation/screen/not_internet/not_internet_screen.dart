import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/string_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/util/app_config.dart';
import '../../../../core/util/app_dimension.dart';

class NotInternetScreen extends StatefulWidget {
   NotInternetScreen({Key? key,required this.onTap}) : super(key: key);
   Function() onTap;

  @override
  State<NotInternetScreen> createState() => _NotInternetScreenState();
}

class _NotInternetScreenState extends State<NotInternetScreen> {

 // late StreamSubscription listener;

  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
    // listener = getIt<InternetConnectionChecker>().onStatusChange.listen((status) {
    //
    //    if(status==InternetConnectionStatus.connected&&mounted)
    //      {
    //       Navigator.pop(context);
    //     }
    //
    // });
  }
  @override
  void dispose() {
   // listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('not_internet');
    return BlocConsumer<NotInternetCubit, bool>(
        listener: (context, state) {
          print("state $state");
          if (!state) {
            // Navigator.pop(context);
          } else {}
        },
        builder: (context, state) {
      return Scaffold(
        body: WillPopScope(
          onWillPop: () async{
            return false;
          },
          child: Container(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/splash_bg.png',
                    ),
                    fit: BoxFit.fill),
              ),
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
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
                     child: Text(_appLocalization.no_internet_connection.capitalize(),style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18.sf(context),color: Colors.white),textAlign: TextAlign.center,),
                   ),
                 ),
                 AppDimension.verticalSize_12,
                 Center(
                   child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 48),
                       child: Text(_appLocalization.check_your_internet.capitalize(),style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15.sf(context),color: Colors.white),maxLines: 2,textAlign:TextAlign.center,)),
                 ),
                const Spacer(),
                       Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(disabledForegroundColor: Colors.white.withOpacity(0.15).withOpacity(0.38), disabledBackgroundColor: Colors.white.withOpacity(0.15).withOpacity(0.12)),
                      onPressed: widget.onTap,
                      child: Text(_appLocalization.try_again.capitalize(),style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14.sf(context),color: Colors.white),)),
                ),
                 AppDimension.verticalSize_32,
               ],
              ),
            ),
          ),
        ),
      );
    }
     );
  }
}
