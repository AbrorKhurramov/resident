import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/filter_float_bottom.dart';
import 'package:resident/feature/presentation/screen/document/component/document_filter_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/document/component/document_list_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../app_route/app_route_name.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: AppRouteName.documentScreen),
        builder: (context) {
      return MultiBlocProvider(providers: [
        BlocProvider<DocumentListCubit>(
          create: (_) => DocumentListCubit(
            getIt<GetDocumentsUseCase>(),
          ),
        )
      ], child: const DocumentScreen());
    });
  }

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;
  String dateFrom = "";
  String dateTo = "";
  int countFilter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/part_first_gradient.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                CustomAppBar(label: _appLocalization.documents.capitalize()),
                DocumentListComponent(key:  ValueKey((countFilter++).toString()),dateFrom:dateFrom,dateTo: dateTo),
              ],
            ),
          )),
      floatingActionButton: FilterFloatBottom(onPressedFilter),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onPressedFilter() {
    showAppModalBottomSheet(
        context: context,
        isExpand: true,
        builder: (context) {
          return DocumentFilterBottomSheet(
            fromDate: dateFrom!=""?dateFrom.parseFilterData(): DateTime(DateTime.now().month>6?DateTime.now().year:DateTime.now().year-1, DateTime.now().month-6,1),
            toDate: dateTo!=""?dateTo.parseFilterData(): DateTime.now().add(const Duration(days: 1)),
          );
        }).then((value) => {
      if(value!=null){
        setState((){
          dateFrom = "${value.fromDate.year}.${value.fromDate.month}.${value.fromDate.day}";
          dateTo = "${value.toDate.year}.${value.toDate.month}.${value.toDate.day}";
        }),
        print("valll${value.fromDate} ${value.toDate}"),

      }
      else print ("nulll")

    });
  }
}
