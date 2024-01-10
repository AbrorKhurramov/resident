import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/util/app_shadow.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';


class OtherCategoryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => getIt<AppealCubit>(),
        child: const OtherCategoryScreen(),
      );
    });
  }

  const OtherCategoryScreen({Key? key}) : super(key: key);

  @override
  State<OtherCategoryScreen> createState() => _OtherCategoryScreenState();
}

class _OtherCategoryScreenState extends State<OtherCategoryScreen> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
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
              CustomAppBar(label: "Выберите категорию",voidCallback:  () {
                Navigator.of(context).pop();
              },),
              AppDimension.verticalSize_18,
              ...List.generate(5, (index) => cardWidget(iconData(index), titleData(index),(){
                Navigator.pushNamed(context, routeName(index));
              })),

            ],
          ),
        ),
      ),
    );
  }

  Widget cardWidget(String iconPath,String title,Function()? onTap){
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: AppShadow.cardShadow,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration:
                const BoxDecoration(shape: BoxShape.circle, color: AppColor.c6000),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                ),
              ),
              AppDimension.horizontalSize_8,
        
              Text(title,style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 12.sf(context), color: AppColor.c4000),),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,size: 12,)
            ],
          ),
        ),
      ),
    );

  }

  String iconData(int type){
    switch(type){
      case 0 : return "assets/icons/mobile_devices.svg";
      case 1 : return "assets/icons/lamp_spark.svg";
      case 2 : return "assets/icons/web.svg";
      case 3 : return "assets/icons/igtv.svg";
      case 4 : return "assets/icons/call.svg";
      default: return "assets/icons/web.svg";
    }

  }
  String routeName(int type){
    switch(type){
      case 0 : return AppRouteName.mobileProvidersScreen;
      case 1 : return AppRouteName.mobileProvidersScreen;
      case 2 : return AppRouteName.mobileProvidersScreen;
      case 3 : return AppRouteName.mobileProvidersScreen;
      case 4 : return AppRouteName.mobileProvidersScreen;
      default: return AppRouteName.mobileProvidersScreen;
    }

  }
  
  
  
  String titleData(int type){
    switch(type){
      case 0 : return "Мобильные операторы";
      case 1 : return "Коммунальные услуги";
      case 2 : return "Интернет провайдеры";
      case 3 : return "Телевизионные услуги";
      case 4 : return "Телефония";
      default: return "Интернет провайдеры";
    }

  }


}
