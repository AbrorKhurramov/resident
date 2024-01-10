
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/filter_float_bottom.dart';
import 'package:resident/feature/presentation/screen/invoice_list/component/invoice_list_tab_component.dart';
import 'package:resident/feature/presentation/screen/invoice_list/component/invoice_list_tab_view_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../injection/injection_container.dart';
import '../../app_route/app_route_name.dart';
import 'component/invoice_filter_bottom_sheet.dart';




class InvoiceListScreen extends StatefulWidget {
  static Route<dynamic> route(String? id) {
    return MaterialPageRoute(settings: const RouteSettings(name: AppRouteName.invoiceScreen),  builder: (context) {
      return  BlocProvider(
  create: (_) =>  getIt<ProfileCubit>(),
  child: InvoiceListScreen(id: id),
);
    });
  }
final String? id;

  const InvoiceListScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController pageController;
  bool isFilter = false;
  String dateFrom = "";
  String dateTo = "";
  int status = 0;
  int type = 0;
  int countFilter = 0;
  late final AppLocalizations _appLocalization;

  List<InvoiceListTabItem>? tabItemList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
    _getTabItems(context.read<AppCubit>().state.user!.registrationDate!);
  }



  _getTabItems(String date) {
    int selectedIndex = 0;
    final List<InvoiceListTabItem> newTabItemList = [];
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    DateTime regDate = dateFormat.parse(date);
    DateTime nowDate = DateTime.now();

    int regYear = regDate.year;
    int regMonth = regDate.month;
    int nowYear = nowDate.year;
    int nowMonth = nowDate.month;

    if (nowYear == regYear) {
      for (int i = regMonth; i <= nowMonth; i++) {
        if (i == nowMonth) {
         // selectedIndex = nowMonth - regMonth;
          newTabItemList.add(InvoiceListTabItem(monthIndex: i, year: regYear, active: true));
        } else {
          newTabItemList.add(InvoiceListTabItem(monthIndex: i, year: regYear, active: false));
        }
      }
    } else {
      for (int i = regYear; i <= nowYear; i++) {
        if (i < nowYear) {
          for (int j = regMonth; j <= 12; j++) {
            newTabItemList.add(InvoiceListTabItem(monthIndex: j, year: regYear, active: false));
          }
        } else {
          for (int j = 1; j <= nowMonth; j++) {
            if (j == nowMonth) {
            //  selectedIndex = j - 1;
              newTabItemList.add(InvoiceListTabItem(monthIndex: j, year: nowYear, active: true));
            } else {
              newTabItemList.add(InvoiceListTabItem(monthIndex: j, year: nowYear, active: false));
            }
          }
        }
      }
    }
    selectedIndex = newTabItemList.length-1;

    setState(() {
      tabItemList = newTabItemList;
      _tabController = TabController(vsync: this, length: tabItemList!.length, initialIndex: selectedIndex);
      pageController = PageController(initialPage: selectedIndex);
      _tabController.addListener(() {
        _changeTabBar(_tabController.index);
      });
    });

    pageController.addListener(() {
      // if(widget.id!=null){
      //   context.read<InvoiceListCubit>().updateInvoiceColor(true);
      // }
      // else {
      //  context.read<InvoiceListCubit>().updateInvoiceColor(false);
      // }
      debugPrint('page:   ${pageController.page!.toString()}');
      debugPrint('offset:   ${pageController.page!.round().toString()}');
      int offSet = pageController.page!.round();

      _changeTabBar(offSet);
    });
  }

  void _changeTabBar(int index) {
    _tabController.animateTo(index);
    setState(() {
      _changedTabIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/part_third_gradient.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: tabItemList != null && tabItemList!.isNotEmpty &&!isFilter
                ? Column(
                    children: [
                      CustomAppBar(label: _appLocalization.invoices.capitalize(),voidCallback: () async{
                       await context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
                        Navigator.of(context).pop();
                      },),
                      AppDimension.verticalSize_16,
                      Expanded(
                        child: DefaultTabController(
                          length: tabItemList!.length,
                          child: Column(
                            children: <Widget>[
                              Container(
                                constraints: const BoxConstraints.expand(height: 50),
                                child: TabBar(
                                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                                  controller: _tabController,
                                  isScrollable: true,
                                  indicatorColor: Colors.transparent,
                                  tabs: tabItemList!
                                      .map((e) => InvoiceListTabComponent(
                                          monthIndex:  e.monthIndex, year: e.year, active: e.active))
                                      .toList(),
                                  onTap: (index) {
                                    debugPrint('index:   ${index.toString()}');
                                    pageController.jumpToPage(index);
                                  },
                                ),
                              ),
                              Expanded(
                                child: PageView(
                                  controller: pageController,
                                  children: tabItemList!
                                      .map((e) =>
                                          InvoiceListTabViewComponent.initInvoiceTabViewComponent(dateFrom: '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.01',
                                            dateTo:  _dateTo(e),id:widget.id,status: status,type: type))
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                :
            isFilter? Column (
              children: [
                CustomAppBar(label: _appLocalization.invoices.capitalize()),
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
                                status = 0;
                                type = 0;
                                isFilter = false;
                              });
                            },
                            child: const Icon(Icons.cancel,color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                AppDimension.verticalSize_16,
                Expanded(
                  child: InvoiceListTabViewComponent.initInvoiceTabViewComponent(dateFrom:dateFrom,
                      dateTo:dateTo,id:widget.id,key: ValueKey((countFilter++).toString()),status:status,type: type))

              ],
            )
                :
            AppDimension.defaultSize,
          )),
      floatingActionButton: FilterFloatBottom(onPressedFilter),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _changedTabIndex(int changedIndex) {
    for (int i = 0; i < tabItemList!.length; i++) {
      if (i == changedIndex) {
        tabItemList![i] = tabItemList![i].copyWith(active: true);
      } else {
        tabItemList![i] = tabItemList![i].copyWith(active: false);
      }
    }
  }

  String _dateTo(InvoiceListTabItem e){
    var date = "";
    switch(e.monthIndex){
      case 1: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
      case 2: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.29'; break;
      case 3: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
      case 4: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.30'; break;
      case 5: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
      case 6: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.30'; break;
      case 7: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
      case 8: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
      case 9: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.30'; break;
      case 10: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
      case 11: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.30'; break;
      case 12: date = '${e.year}.${e.monthIndex.toString().getMonthIndexLabel()}.31'; break;
    }
    return date;
  }

  void onPressedFilter() {
    showAppModalBottomSheet(
        context: context,
        isExpand: true,
        builder: (context) {
          return InvoiceFilterBottomSheet(
            selectedStatusIndex: status,
            selectedTypeIndex: type,
            fromDate: dateFrom!=""?dateFrom.parseFilterData(): DateTime(DateTime.now().month>6?DateTime.now().year:DateTime.now().year-1, DateTime.now().month-6,1),
            toDate: dateTo!=""?dateTo.parseFilterData(): DateTime.now().add(const Duration(days: 1)),
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
            print("status${value.selectedStatusIndex} type${value.selectedTypeIndex}"),

          }
      else print ("nulll")
    });
  }
}
