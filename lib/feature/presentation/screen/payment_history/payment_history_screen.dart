import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/filter_float_bottom.dart';
import 'package:resident/feature/presentation/screen/payment_history/component/payment_history_filter_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/payment_history/component/payment_history_list_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app_route/app_route_name.dart';

class PaymentHistoryScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: AppRouteName.paymentHistoryScreen),
        builder: (context) {
      return BlocProvider(
        create: (_) => getIt<PaymentHistoryCubit>(),
        child: const PaymentHistoryScreen(),
      );
    });
  }

  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late AppLocalizations _appLocalization;
  bool isFilter = false;
  String dateFrom = "";
  String dateTo = "";
  int? confirmType;
  int countFilter = 0;
  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_first_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(label: _appLocalization.replenishment_history.capitalize()),
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
                          Text(_appLocalization.filter_date("${dateFrom.parseFilterData().day}.${dateFrom.parseFilterData().month}.${dateFrom.parseFilterData().year}", "${dateTo.parseFilterData().day}.${dateTo.parseFilterData().month}.${dateTo.parseFilterData().year}"),style: TextStyle(fontSize: 14.sf(context)),),
                          const SizedBox(width: 5),
                          GestureDetector(
                              onTap: (){
                                setState((){
                                  dateFrom = "";
                                  dateTo = "";
                                  confirmType = null;
                                  isFilter = false;
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
              PaymentHistoryListComponent(key:  ValueKey((countFilter++).toString()), dateFrom: dateFrom,dateTo: dateTo,confirmType: confirmType),
            ],
          ),
        ),
      ),
      floatingActionButton: FilterFloatBottom(onPressedFilter),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onPressedFilter() {
    showAppModalBottomSheet(
        context: context,
        isExpand: true,
        builder: (context) {
          return PaymentHistoryFilterBottomSheet(
            selectedTypeIndex : confirmType ?? 0,
            fromDate: dateFrom!=""?dateFrom.parseFilterData(): DateTime(DateTime.now().month>6?DateTime.now().year:DateTime.now().year-1, DateTime.now().month-6,1),
            toDate: dateTo!=""?dateTo.parseFilterData(): DateTime.now().add(const Duration(days: 1)),

          );
        }).then((value) => {
      if(value!=null){
        setState((){
          isFilter = true;
          confirmType = value.selectedTypeIndex;
          dateFrom = "${value.fromDate.year}.${value.fromDate.month}.${value.fromDate.day}";
          dateTo = "${value.toDate.year}.${value.toDate.month}.${value.toDate.day}";
        }),
        print("valll${value.fromDate} ${value.toDate}"),

      }
      else print("nulll")
    });
  }
}
