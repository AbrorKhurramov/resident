
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBottomSheet extends StatefulWidget {
   SupportBottomSheet({Key? key,required this.isLogin}) : super(key: key);
bool isLogin;
  @override
  State<SupportBottomSheet> createState() => _SupportBottomSheetState();
}

class _SupportBottomSheetState extends State<SupportBottomSheet> {
  late AppLocalizations _appLocalization;

  @override
  void dispose() {
    super.dispose();
  }



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(widget.isLogin) {
      context.read<SupportCubit>().getSupport(context.read<AppCubit>().getActiveApartment().id);
    }
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return BlocConsumer<SupportCubit, SupportState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        if (state.stateStatus == StateStatus.paginationLoading || state.stateStatus == StateStatus.success || !widget.isLogin)
{
 if(widget.isLogin){
   if(state.response!.data.isNotEmpty) {
     BasePaginationListResponse<Support> response = state.response!;
     return Scaffold(
       backgroundColor: Colors.white,
       resizeToAvoidBottomInset: true,
       body: SingleChildScrollView(
         child: SizedBox(
           width: AppConfig.screenWidth(context),
           height: AppConfig.screenHeight(context) * 0.9,
           child: Padding(
             padding: EdgeInsets.all(16),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                 AppDimension.verticalSize_16,
                 Text(
                   _appLocalization.support.capitalize(),
                   style: Theme
                       .of(context)
                       .textTheme
                       .headline2!
                       .copyWith(color: AppColor.c4000, fontSize: 17.sf(context)),
                 ),
                 SizedBox(height: 48),
                 Column(
                   children: List.generate(response.data.length, (index) => Column(
                     children: [
                       GestureDetector(
                         onTap: (){
                           response.data[index].type==1 ?  _launchUrl(response.data[index].contactData) :
                           _launchUrl("tel://${response.data[index].contactData}");
                         },
                         child: _initInfoItem(
                             iconData(response.data[index].type),
                             response.data[index].type==1?_appLocalization.write_telegram:_appLocalization.support_phone, response.data[index].contactPerson),
                       ),
                       AppDimension.verticalSize_32,
                     ],
                   )),
                 ),
                 const Spacer(),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 36),
                   child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           onSurface: AppColor.c6000.withOpacity(0.15),
                           primary: AppColor.c6000),
                       onPressed: () {
                         Navigator.of(context).pop();
                       },
                       child: Text(_appLocalization.close.capitalize(),style: TextStyle(fontSize: 14.sf(context)))),
                 )
               ],
             ),
           ),
         ),
       ),
     );
   }
 }
  else {
   return Scaffold(
   backgroundColor: Colors.white,
   resizeToAvoidBottomInset: true,
   body: SingleChildScrollView(
     child: SizedBox(
       width: AppConfig.screenWidth(context),
       height: AppConfig.screenHeight(context) * 0.9,
       child: Padding(
         padding: EdgeInsets.all(16),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
             AppDimension.verticalSize_16,

             Text(
               _appLocalization.support.capitalize(),
               style: Theme
                   .of(context)
                   .textTheme
                   .headline2!
                   .copyWith(color: AppColor.c4000, fontSize: 17),
             ),
             SizedBox(height: 48),
             Column(
               children: [
                 GestureDetector(
                   onTap: () => _launchUrl("tel://+998977771098"),
                   child: _initInfoItem('assets/icons/phone.svg',
                       _appLocalization.support_phone, '+998 97 777 10 98'),
                 ),
                 AppDimension.verticalSize_32,
                 GestureDetector(
                   onTap: ()=> _launchUrl("https://t.me/resident_support_official"),
                   child: _initInfoItem('assets/icons/telegram.svg',
                       _appLocalization.write_telegram, 't.me/resident_support_official'),
                 ),

               ],
             ),
             const Spacer(),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 36),
               child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                       onSurface: AppColor.c6000.withOpacity(0.15),
                       primary: AppColor.c6000),
                   onPressed: () {
                     Navigator.of(context).pop();
                   },
                   child: Text(_appLocalization.close.capitalize())),
             )
           ],
         ),
       ),
     ),
   ),
 );
 }

}
        if (state.stateStatus == StateStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox();

      },
    );
  }

  String iconData(int type){
    switch(type){
      case 1 : return "assets/icons/telegram.svg";
      case 2 : return "assets/icons/phone.svg";
      default: return "assets/icons/phone.svg";
    }

  }

  Widget _initInfoItem(String path, String desc, String info) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration:
          BoxDecoration(shape: BoxShape.circle, color: AppColor.c6000),
          child: Center(
            child: SvgPicture.asset(
              path,
              color: Colors.white,
              fit: BoxFit.none,
            ),
          ),
        ),
        AppDimension.horizontalSize_8,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc.capitalize(),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppColor.c3000, fontSize: 11.sf(context)),
            ),
            Text(info,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColor.c4000, fontSize: 14.sf(context))),
          ],
        )
      ],
    );
  }
  void _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) throw 'Could not launch $url';
  }
}
