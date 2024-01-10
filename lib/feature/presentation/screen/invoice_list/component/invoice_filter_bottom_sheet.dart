import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/component/range_date_component.dart';


class InvoiceFilterBottomSheet extends StatefulWidget {
  DateTime fromDate;
  DateTime toDate;
int selectedStatusIndex;
int selectedTypeIndex;


  InvoiceFilterBottomSheet({Key? key, required this.selectedStatusIndex,required this.selectedTypeIndex, required this.fromDate,required this.toDate}) : super(key: key);

  @override
  State<InvoiceFilterBottomSheet> createState() => InvoiceFilterBottomSheetState();
}

class InvoiceFilterBottomSheetState extends State<InvoiceFilterBottomSheet> {
  late AppLocalizations _appLocalization;
  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;

    var status = [
      _appLocalization.all,
      _appLocalization.paid,
      _appLocalization.awaiting_payment,
      _appLocalization.canceled,
    ];
    var categories = [
      _appLocalization.all,
      _appLocalization.electricity,
      _appLocalization.hot_water,
      _appLocalization.cold_water,
      _appLocalization.gas,
      _appLocalization.others,
    ];

    return SizedBox(
      width: AppConfig.screenWidth(context),
      height: AppConfig.screenHeight(context) * 0.7,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(child: SvgPicture.asset('assets/icons/modal_bottom_top_line.svg')),
            AppDimension.verticalSize_16,
            Center(
              child: Text(
                _appLocalization.filter.capitalize(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 17.sf(context), color: AppColor.c4000),
              ),
            ),
            AppDimension.verticalSize_24,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _appLocalization.date.capitalize(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14.sf(context), color: AppColor.c3000),
              ),
            ),
            AppDimension.verticalSize_12,
            Row(
              children: [
                Flexible(
                    child: RangeDateComponent(
                        title: _appLocalization.from,
                        chosenDate: widget.fromDate.formatCalendarDateTime(),
                        onPressed: () {
                          _openFromDateTimePicker();
                        })),
                AppDimension.horizontalSize_8,
                Flexible(
                    child: RangeDateComponent(
                        title: _appLocalization.to,
                        chosenDate: widget.toDate.formatCalendarDateTime(),
                        onPressed: () {
                          _openToDateTimePicker();
                        })),
              ],
            ),
            AppDimension.verticalSize_24,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _appLocalization.status.capitalize(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14.sf(context), color: AppColor.c3000),
              ),
            ),
            AppDimension.verticalSize_12,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(4, (index) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        widget.selectedStatusIndex = index;
                      });
                    },
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: index==widget.selectedStatusIndex?null: Border.all(color: Colors.black),
                          color: index==widget.selectedStatusIndex?const Color.fromRGBO(56, 145, 250, 1):Colors.white
                      ),
                      child: Center(child: Text(status[index],style: TextStyle(fontSize: 12.sf(context),fontWeight: FontWeight.w500,color: index==widget.selectedStatusIndex?Colors.white:Colors.black),)),
                    ),
                  ),
                ),
                ),
              ),
            ),
            AppDimension.verticalSize_24,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _appLocalization.categories.capitalize(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14.sf(context), color: AppColor.c3000),
              ),
            ),
            AppDimension.verticalSize_12,
            Wrap(
              runSpacing: 10,
              spacing: 10,
              direction: Axis.horizontal,
              children: List.generate(categories.length, (index) => GestureDetector(
                onTap: (){
                  setState(() {
                    if(index!=5) {
                      widget.selectedTypeIndex = index;
                    }
                    else {
                      widget.selectedTypeIndex = -1;
                    }
                  });
                },
                child: Container(
                 padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: index==widget.selectedTypeIndex||(index==5&&widget.selectedTypeIndex==-1)?null: Border.all(color: Colors.black),
                    color: index==widget.selectedTypeIndex||(index==5&&widget.selectedTypeIndex==-1)?const Color.fromRGBO(56, 145, 250, 1):Colors.white
                  ),
                  child: Text(categories[index].capitalize(),style: TextStyle(fontSize: 12.sf(context),fontWeight: FontWeight.w500,color: index==widget.selectedTypeIndex||(index==5&&widget.selectedTypeIndex==-1)?Colors.white:Colors.black)),
                ),
              )),
            ),

            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: AppColor.c60000),
                      onPressed: () {
                        setState(() {
                          widget.fromDate = DateTime(DateTime.now().month>6?DateTime.now().year:DateTime.now().year-1, DateTime.now().month-6,1);
                          widget.toDate = DateTime.now().add(const Duration(days: 1));
                          widget.selectedStatusIndex = 0;
                          widget.selectedTypeIndex = 0;
                        });
                      },
                      child: Text(_appLocalization.reset.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)))),
                ),
                AppDimension.horizontalSize_8,
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context,FilterDate(selectedStatusIndex: widget.selectedStatusIndex,selectedTypeIndex: widget.selectedTypeIndex, fromDate: widget.fromDate, toDate: widget.toDate));
                      },
                      child: Text(_appLocalization.ready.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)))),
                )
              ],
            ),
            AppDimension.verticalSize_16,
          ],
        ),
      ),
    );
  }

  _openFromDateTimePicker() {
    return showRoundedDatePicker(
      height: MediaQuery.of(context).size.height*0.56,
      context: context,
      initialDate: widget.fromDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
      initialDatePickerMode: DatePickerMode.day,

    ).then((value) {
      if (value != null) {
        setState(() {

          widget.fromDate = value;
        });
      }
      return null;
    });
  }

  _openToDateTimePicker() {
    return showRoundedDatePicker(
      height: MediaQuery.of(context).size.height*0.56,
      context: context,
      initialDate: widget.toDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
      initialDatePickerMode: DatePickerMode.day,
    ).then((value) {
      if (value != null) {
        if (value.isBefore(widget.fromDate)) {
          showErrorFlushBar(context, _appLocalization.date_is_incorrect);
          return null;
        }
        setState(() {
          widget.toDate = value;
        });
      }
      return null;
    });
  }
}




class FilterDate {
  final DateTime? fromDate;
  final DateTime? toDate;
  final int selectedStatusIndex;
  final int selectedTypeIndex;


  FilterDate({required this.selectedStatusIndex,required this.selectedTypeIndex, required this.fromDate,required this.toDate});
}