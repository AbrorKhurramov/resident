import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/bloc/appeal_history_cubit/appeal_history_cubit.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/filter_float_bottom.dart';
import 'package:resident/feature/presentation/screen/appeal_history/component/appeal_history_filter_bottom_sheet.dart';

import '../../../domain/entity/response/appeal_type.dart';
import '../../app_route/app_route_name.dart';
import '../../bloc/app_cubit/app_cubit.dart';
import '../../bloc/appeal_cubit/appeal_cubit.dart';
import 'component/appeal_history_list_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';




class AppealHistoryScreen extends StatefulWidget {
  // List<AppealType>? appealTypes;
  static Route<dynamic> route() {
    return MaterialPageRoute(settings: RouteSettings(name: AppRouteName.appealHistoryScreen),  builder: (context) {
      return MultiBlocProvider(
        providers:[
          BlocProvider(
            create: (_) => getIt<AppealHistoryCubit>(),
          ),
          BlocProvider(
            create: (_) => getIt<AppealCubit>(),
          ),
        ],
          child: AppealHistoryScreen()
      );
    });
  }

   const AppealHistoryScreen({Key? key}) : super(key: key);

  @override
  State<AppealHistoryScreen> createState() => _AppealHistoryScreenState();
}

class _AppealHistoryScreenState extends State<AppealHistoryScreen> {
  late AppLocalizations _appLocalization;
  String dateFrom = "";
  String dateTo = "";
  bool isFilter = false;
  int status = 0;
  int type = 0;
  int countFilter = 0;
  List<AppealType> appealTypes = [];


  @override
  void didChangeDependencies() {
    context.read<AppealCubit>().getInitialAppeal(
        context.read<AppCubit>().getActiveApartment().id, 0);
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;


    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_third_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(label: _appLocalization.history_appeal.capitalize(),voidCallback:  () {
               if(isFilter){
                 setState((){
                   dateFrom = "";
                   dateTo = "";
                   status = 0;
                   type = 0;
                   isFilter = false;
                 });
               }
               else {
                 Navigator.of(context).pop();
               }
              },),
              AppealHistoryListComponent(key: ValueKey((countFilter++).toString()),status: status==0?null:status-1,type: type==0?null:type,dateFrom:dateFrom,dateTo: dateTo),
            ],
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<AppealCubit,AppealState>(
          listener:(context,state){
            if(state.stateStatus == StateStatus.success){
              appealTypes = state.response!.data;
            }
          },
          builder:(context,state)=>  FilterFloatBottom(onPressedFilter)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onPressedFilter() {
    showAppModalBottomSheet(
        context: context,
        isExpand: true,
        builder: (context) {
          return AppealHistoryFilterBottomSheet(
              appealTypes: appealTypes,
              selectedStatusIndex: status,
              selectedTypeIndex: type,
              fromDate: dateFrom!=""?dateFrom.parseFilterData(): DateTime(DateTime.now().month>6?DateTime.now().year:DateTime.now().year-1, DateTime.now().month-6,1),
              toDate: dateTo!=""?dateTo.parseFilterData(): DateTime.now().add(Duration(days: 1)),

          );
        }).then((value) => {
      if(value!=null){
        setState((){
          isFilter = true;
          dateFrom = "${value.fromDate.year}.${value.fromDate.month}.${value.fromDate.day}";
          dateTo = "${value.toDate.year}.${value.toDate.month}.${value.toDate.day}";
          status =  value.selectedStatusIndex ;
          type =  value.selectedTypeIndex ;
        }),
        print("valll${value.fromDate} ${value.toDate}"),

      }
      else print ("nulll")

    });
  }
}
