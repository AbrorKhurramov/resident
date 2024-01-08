import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/filter_float_bottom.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/indication_history/component/indication_history_list_component.dart';

import '../../../domain/entity/response/counter.dart';
import 'component/indication_history_filter_bottom_sheet.dart';

class IndicationHistoryScreenParam{
  final int type;
  final List<Counter> counter;

  IndicationHistoryScreenParam({required this.type,required this.counter});
}

class IndicationHistoryScreen extends StatefulWidget {
  List<Counter> counter;
  static Route<dynamic> route(IndicationHistoryScreenParam indicationHistoryScreenParam) {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => IndicationHistoryCubit(
          getServiceResultUseCase: getIt<GetServiceResultUseCase>(),
          type: indicationHistoryScreenParam.type,
        ),
        child: IndicationHistoryScreen(counter: indicationHistoryScreenParam.counter),
      );
    });
  }

   IndicationHistoryScreen({Key? key,required this.counter}) : super(key: key);

  @override
  State<IndicationHistoryScreen> createState() =>
      _IndicationHistoryScreenState();
}

class _IndicationHistoryScreenState extends State<IndicationHistoryScreen> {
  late AppLocalizations _appLocalization;
  bool isFilter = false;
  String dateFrom = "";
  String dateTo = "";
  int selectedIndex=0;
  int countFilter = 0;
  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_third_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(label: _appLocalization.history_indication.capitalize()),
             if(isFilter) Column(
                children: [
                  AppDimension.verticalSize_16,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_appLocalization.filter_date("${dateFrom.parseFilterData().day}.${dateFrom.parseFilterData().month}.${dateFrom.parseFilterData().year}", "${dateTo.parseFilterData().day}.${dateTo.parseFilterData().month}.${dateTo.parseFilterData().year}")),
                          const SizedBox(width: 5),
                          GestureDetector(
                              onTap: (){
                                setState((){
                                  dateFrom = "";
                                  dateTo = "";
                                  isFilter = false;
                                  selectedIndex = 0;
                                });
                              },
                              child: const Icon(Icons.cancel,color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  AppDimension.verticalSize_16,
                ],
              ),
              IndicationHistoryListComponent(key:  ValueKey((countFilter++).toString()),counterId:selectedIndex!=0? widget.counter[selectedIndex-1].id:null, dateFrom: dateFrom,dateTo: dateTo)
            ],
          ),
        ),
      ),
      floatingActionButton: FilterFloatBottom(onPressedFilter),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onPressedFilter() async{
     showAppModalBottomSheet(
        context: context,
        isExpand: true,
        builder: (context) {
          return IndicationHistoryFilterBottomSheet(
            counter: widget.counter,
            selectedIndex: selectedIndex,
            fromDate: dateFrom!=""?dateFrom.parseFilterData(): DateTime(DateTime.now().month>6?DateTime.now().year:DateTime.now().year-1, DateTime.now().month-6,1),
            toDate: dateTo!=""?dateTo.parseFilterData(): DateTime.now().add(const Duration(days: 1)),
          );
        }).then((value) => {
       if(value!=null){
         setState((){
           isFilter = true;
           dateFrom = "${value.fromDate.year}.${value.fromDate.month}.${value.fromDate.day}";
           dateTo = "${value.toDate.year}.${value.toDate.month}.${value.toDate.day}";
             selectedIndex = value.selectedIndex;
         }),
         print("valll${value.fromDate} ${value.toDate}"),

       }
       else print ("nulll")
     });

  }
}
