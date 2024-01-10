import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';


class MobileProvidersScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => getIt<AppealCubit>(),
        child: const MobileProvidersScreen(),
      );
    });
  }

  const MobileProvidersScreen({Key? key}) : super(key: key);

  @override
  State<MobileProvidersScreen> createState() => _MobileProvidersScreenState();
}

class _MobileProvidersScreenState extends State<MobileProvidersScreen> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }


  @override
  Widget build(BuildContext context) {
    debugPrint("WIDTH");
    debugPrint(AppConfig.screenWidth(context).toString());
    debugPrint("Height");
    debugPrint(AppConfig.screenHeight(context).toString());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/part_third_gradient.png',
              ),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(label: "Мобильные операторы",voidCallback:  () {
                Navigator.of(context).pop();
              },),
              AppDimension.verticalSize_24,
              Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  childAspectRatio:AppConfig.ratio(context),
                  crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: List.generate(6, (index) => cardWidget(iconData(index), titleData(index))),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardWidget(String iconPath,String title){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: [
          AppDimension.verticalSize_4,
          ClipOval(
              child: Image.asset(iconPath,width: 52,height: 52,)),
          AppDimension.verticalSize_20,
          Text(title,style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontSize: 10.sf(context), color: AppColor.c4000),),
        ],
      ),
    );

  }

  String iconData(int type){
    switch(type){
      case 0 : return "assets/images/humans.png";
      case 1 : return "assets/images/beeline.png";
      case 2 : return "assets/images/mobiuz.png";
      case 3 : return "assets/images/ucell.png";
      case 4 : return "assets/images/uzmobile.png";
      case 5 : return "assets/images/perfectum.png";
      default : return "assets/images/humans.png";
     
    }

  }
  String titleData(int type){
    switch(type){
      case 0 : return "Humans";
      case 1 : return "Beeline";
      case 2 : return "Mobiuz";
      case 3 : return "Ucell";
      case 4 : return "Uzmobile";
      case 5 : return "Perfectum Mobile";
      default: return "Humans";
    }

  }


}
