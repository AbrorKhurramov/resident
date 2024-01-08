import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/core/extension/size_extension.dart';

class ServiceResultHistoryComponent extends StatefulWidget {
  final int type;
  final bool isPhysics;

  const ServiceResultHistoryComponent({
    Key? key,
    required this.type,
    required this.isPhysics,
  }) : super(key: key);

  @override
  State<ServiceResultHistoryComponent> createState() => _ServiceResultHistoryComponentState();
}

class _ServiceResultHistoryComponentState extends State<ServiceResultHistoryComponent> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
    context.read<ServiceResultCubit>().getServiceList(widget.type, context.read<AppCubit>().getActiveApartment().id);
  }

  @override
  Widget build(BuildContext context) {
    // int a;
    return Expanded(
      child: BlocConsumer<ServiceResultCubit, ServiceResultState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.stateStatus == StateStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.stateStatus == StateStatus.success) {
              return ListView.builder(
                physics: widget.isPhysics?NeverScrollableScrollPhysics():BouncingScrollPhysics(),
                padding: EdgeInsets.all(4),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(widget.type.getCommunalType().getIconPath()),
                          AppDimension.horizontalSize_8,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.type.getCommunalType().getLabel(_appLocalization),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(fontSize: 14.sf(context), color: AppColor.c4000),
                              ),
                              Text(state.response!.data[index].getCounterInfo(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(fontSize: 10.sf(context), color: AppColor.c3000)),
                            ],
                          ),
                        ],
                      ),
                      AppDimension.verticalSize_12,
                      _initDateAndCounterReading(state.response!.data[index]),
                      Divider(thickness: 1)
                    ],
                  );
                },
                itemCount: state.response!.data.length,
                itemExtent: 88,
              );
            }
            return SizedBox();
          }),
    );
  }

  Widget _initDateAndCounterReading(ServiceResult serviceResult) {

    //DateTime createdDate = serviceResult.createdDate!.parseDateTime();

    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _appLocalization.date.capitalize(),
                style: Theme.of(context).textTheme.headline3!.copyWith(color: AppColor.c3000, fontSize: 10.sf(context)),
              ),
              Text(
                serviceResult.createdDate!.getDateWithHour(_appLocalization),
           //     '${createdDate.getDay()} ${createdDate.getMonthLabel(_appLocalization)} ${createdDate.year}, ${serviceResult.createdDate!.getHourAndMinute()}',
                style: Theme.of(context).textTheme.headline2!.copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _appLocalization.counter_indication.capitalize(),
                style: Theme.of(context).textTheme.headline3!.copyWith(color: AppColor.c3000, fontSize: 10.sf(context)),
              ),
              Text(
                serviceResult.result?.toString() ?? '',
                style: Theme.of(context).textTheme.headline2!.copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
