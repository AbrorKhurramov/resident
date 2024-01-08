import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/doings/doings_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceMenuComponent extends StatefulWidget {
  const ServiceMenuComponent({Key? key}) : super(key: key);

  @override
  State<ServiceMenuComponent> createState() => _ServiceMenuComponentState();
}

class _ServiceMenuComponentState extends State<ServiceMenuComponent> {
  late AppLocalizations _appLocalization;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;

  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _initRowItem(
                  'assets/icons/send.svg', _appLocalization.appeal.capitalize(),
                      () {
                    _openScreen(AppRouteName.appealScreen);
                  }, profileState.notificationsCount!=null?profileState.notificationsCount!.regApplicationReplyCount!:0),
              _initRowItem(
                  'assets/icons/votes.svg', _appLocalization.survey.capitalize(),
                      () {
                    _openScreen(AppRouteName.surveyScreen);
                  },profileState.notificationsCount!=null?profileState.notificationsCount!.surveyCount!:0),
              _initRowItem(
                  'assets/icons/calendar.svg', _appLocalization.doings.capitalize(),
                      () {
                    Navigator.pushNamed(context, AppRouteName.eventsScreen);
                    // _openDoingsBottomSheet();
                  },profileState.notificationsCount!=null?profileState.notificationsCount!.serviceCount!:0),
              _initRowItem('assets/icons/receipt.svg',
                  _appLocalization.invoices.capitalize(), () {
                    _openScreen(AppRouteName.invoiceScreen);
                  },profileState.notificationsCount!=null?profileState.notificationsCount!.invoiceCount!:0)
            ],
          ),


        );
      },
    );
    _appLocalization = AppLocalizations.of(context)!;
  }

  Widget _initRowItem(String iconPath, String label, VoidCallback onPressed,int isNotification ) {
    return Column(
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: Stack(
            children: [

              Center(child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(64, 64),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    primary: Colors.white,
                    onPrimary: Theme.of(context).primaryColor,
                    elevation: 0,
                  ),
                  child: SvgPicture.asset(iconPath))),
              Visibility(
                visible: isNotification>0,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red[500]
                    ),
                    child: Center(child: Text(isNotification.toString(),style: TextStyle(fontSize: 10.sf(context),fontWeight: FontWeight.w500,color: Colors.white),)),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppDimension.verticalSize_16,
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: AppColor.c4000, fontSize: 12.sf(context)),
        )
      ],
    );
  }

  void _openScreen(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void _openDoingsBottomSheet() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return const DoingsBottomSheet();
        });
  }
}
