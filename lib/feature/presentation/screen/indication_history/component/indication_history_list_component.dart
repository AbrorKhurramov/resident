import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndicationHistoryListComponent extends StatefulWidget {
   IndicationHistoryListComponent({Key? key,this.counterId, required this.dateFrom,required this.dateTo}) : super(key: key);
   String? counterId;
   String dateFrom;
   String dateTo;
  @override
  State<IndicationHistoryListComponent> createState() => _IndicationHistoryListComponentState();
}

class _IndicationHistoryListComponentState extends State<IndicationHistoryListComponent> {
  int page = 0;

  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<IndicationHistoryCubit>().getIndicationHistory(page, context.read<AppCubit>().getActiveApartment().id,widget.counterId,widget.dateFrom,widget.dateTo);
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return BlocConsumer<IndicationHistoryCubit, IndicationHistoryState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.loadingFailure!);
        } else if (state.stateStatus == StateStatus.paginationFailure) {
          MyApp.failureHandling(context, state.paginationLoadingFailure!);
        }
      },
      builder: (context, state) {
        if (state.stateStatus == StateStatus.paginationLoading || state.stateStatus == StateStatus.success) {
          if (state.response!.data.isNotEmpty) {
            BasePaginationListResponse<ServiceResult> response = state.response!;
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async{
                  print("onred");
                 context.read<IndicationHistoryCubit>().getIndicationHistory(
                      response.currentPage, context.read<AppCubit>().getActiveApartment().id,"",widget.dateFrom,widget.dateTo);
                },
                child: GroupListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  sectionsCount: state.sortedIndication.keys.toList().length,
                  countOfItemInSection: (int section) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedIndication.values.length - 1 == section) {
                      return state.sortedIndication.values.toList()[section].length + 1;
                    }
                    return state.sortedIndication.values.toList()[section].length;
                  },
                  itemBuilder: (context, indexPath) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedIndication.values.length - 1 == indexPath.section &&
                        indexPath.index == state.sortedIndication.values.toList()[indexPath.section].length) {
                      if (state.stateStatus != StateStatus.paginationLoading) {
                        context.read<IndicationHistoryCubit>().getPaginationIndicationHistory(
                            response.currentPage + 1, context.read<AppCubit>().getActiveApartment().id,"",widget.dateFrom,widget.dateTo);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _initItem(
                        state.type, state.sortedIndication.values.toList()[indexPath.section][indexPath.index]);
                  },
                  groupHeaderBuilder: (BuildContext context, int section) {
                    return _initGroupHeader(state.sortedIndication.keys.toList()[section]);
                  },
                  separatorBuilder: (context, index) => AppDimension.verticalSize_12,
                  sectionSeparatorBuilder: (context, section) => AppDimension.verticalSize_12,
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppEmptyCard(
                  path: 'assets/icons/empty_indication_history.svg', description: _appLocalization.empty_document),
            );
          }
        }
        if (state.stateStatus == StateStatus.loading) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _initGroupHeader(String label) {


    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: Colors.white,
          ),
          child: Text(
           label.getDateWithoutHour(_appLocalization),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 12.sf(context),
              color: AppColor.c3000,
            ),
          ),
        ),
      ),
    );

    // return Container(
    //   padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(16)),
    //     color: Colors.white,
    //   ),
    //   child: Text(
    //     label,
    //     style: Theme.of(context).textTheme.headline3!.copyWith(
    //           fontSize: 12.sf(context),
    //           color: AppColor.c3000,
    //         ),
    //   ),
    // );
  }

  Widget _initItem(int type, ServiceResult serviceResult) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SvgPicture.asset(type.getCommunalType().getIconPath()),
              AppDimension.horizontalSize_8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    type.getCommunalType().getLabel(_appLocalization).capitalize(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14.sf(context), color: AppColor.c4000),
                  ),
                  Text(serviceResult.getCounterInfo(),
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 10.sf(context), color: AppColor.c3000)),
                ],
              ),
              AppDimension.horizontalSize_8,
              const Spacer(),
              Text(
                serviceResult.createdDate!.getHourAndMinute(),
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 16.sf(context),
                      color: AppColor.c3000,
                    ),
              ),
            ],
          ),
          AppDimension.verticalSize_16,
          Row(
            children: [
              Text(_appLocalization.counter_indication.capitalize(),
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sf(context), color: AppColor.c3000)),
              const Spacer(),
              Text(serviceResult.result?.toString() ?? '',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12.sf(context), color: AppColor.c4000))
            ],
          )
        ],
      ),
    );
  }
}
