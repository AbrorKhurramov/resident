import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/screen/payment_history/component/payment_bottom_sheet.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaymentHistoryListComponent extends StatefulWidget {
   PaymentHistoryListComponent({Key? key,required this.dateFrom,required this.dateTo,this.confirmType}) : super(key: key);
  String dateFrom;
  String dateTo;
   int? confirmType;

  @override
  State<PaymentHistoryListComponent> createState() =>
      _PaymentHistoryListComponentState();
}

class _PaymentHistoryListComponentState
    extends State<PaymentHistoryListComponent> {
  int page = 0;
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<PaymentHistoryCubit>().getPaymentHistory(
        page, context.read<AppCubit>().getActiveApartment().id,widget.dateFrom,widget.dateTo,widget.confirmType);
  }

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return BlocConsumer<PaymentHistoryCubit, PaymentHistoryState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.failure) {
          MyApp.failureHandling(context, state.loadingFailure!);
        } else if (state.stateStatus == StateStatus.paginationFailure) {
          MyApp.failureHandling(context, state.paginationLoadingFailure!);
        }
      },
      builder: (context, state) {
        if (state.stateStatus == StateStatus.success ||
            state.stateStatus == StateStatus.paginationLoading) {
          if (state.response!.data.isNotEmpty) {
            BasePaginationListResponse<Payment> response = state.response!;
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<PaymentHistoryCubit>().getPaymentHistory(
                      page, context.read<AppCubit>().getActiveApartment().id,widget.dateFrom,widget.dateTo,widget.confirmType);
                },
                child: GroupListView(
                 shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  sectionsCount: state.sortedPayment.keys.toList().length,
                  countOfItemInSection: (int section) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedPayment.values.length - 1 == section) {
                      return state.sortedPayment.values.toList()[section].length +
                          1;
                    }
                    return state.sortedPayment.values.toList()[section].length;
                  },
                  itemBuilder: (context, indexPath) {
                    if (response.totalPages != response.currentPage + 1 &&
                        state.sortedPayment.values.length - 1 ==
                            indexPath.section &&
                        indexPath.index ==
                            state.sortedPayment.values
                                .toList()[indexPath.section]
                                .length) {
                      if (state.stateStatus != StateStatus.paginationLoading) {
                        context
                            .read<PaymentHistoryCubit>()
                            .getPaginationPaymentHistory(response.currentPage + 1,
                                context.read<AppCubit>().getActiveApartment().id,widget.dateFrom,widget.dateTo,widget.confirmType);
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                    return _initItem(state.sortedPayment.values
                        .toList()[indexPath.section][indexPath.index]);
                  },
                  groupHeaderBuilder: (BuildContext context, int section) {
                    return _initGroupHeader(
                        state.sortedPayment.keys.toList()[section]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  sectionSeparatorBuilder: (context, section) =>
                      const SizedBox(height: 12),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppEmptyCard(
                  path: 'assets/icons/empty_replenish_history.svg',
                  description: _appLocalization.empty_replenish_balance_history),
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

  Widget _initItem(Payment payment) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppDimension.verticalSize_12,
        ElevatedButton(
          onPressed: () {
            showAppModalBottomSheet(
                context: context,
                isExpand: true,
                builder: (context) {
                  return PaymentBottomSheet(payment: payment);
                });
          },
          style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor, fixedSize: const Size(double.infinity, double.infinity), backgroundColor: Colors.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(16)))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _initItemHeader(payment),
                AppDimension.verticalSize_16,
                _initItemStatusAndAmount(payment),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _initItemHeader(Payment payment) {
    return SizedBox(
      height: 36,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/payment.svg'),
          AppDimension.horizontalSize_8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _appLocalization.replenishment_check.capitalize(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 14.sf(context), color: AppColor.c4000),
                  ),
                ),
                Expanded(
                  child: Text(
                    _getApartmentComplexAndInfo(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 12.sf(context), color: AppColor.c4000),
                  ),
                ),
              ],
            ),
          ),
          AppDimension.horizontalSize_8,
          Text(
            payment.createdDate!.getHourAndMinute(),
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontSize: 13.sf(context), color: AppColor.c3000),
          ),
        ],
      ),
    );
  }

  Widget _initItemStatusAndAmount(Payment payment) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: payment.confirmType!=2?AppColor.c7000:AppColor.c50000,
          ),
          child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
               payment.confirmType!=2? _appLocalization.successfully.toUpperCase():_appLocalization.canceled.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 10.sf(context),
                      color: Colors.white,
                    ),
              )),
        ),
        AppDimension.horizontalSize_8,
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '+ ${(payment.amount!~/100).currencyFormat()} ${_appLocalization.sum}',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 20.sf(context),
                    color: Colors.black,
                  ),
            ),
            Text(
            payment.cardNumber!=null?  payment.cardNumber.toString():"",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 12.sf(context),
                    color: AppColor.c3000,
                  ),
            )
          ],
        )
      ],
    );
  }

  String _getApartmentComplexAndInfo() {
    String languageCode = context.read<LanguageCubit>().languageCode();
    Apartment apartment = context.read<AppCubit>().getActiveApartment();
    String complex = apartment.complex?.name ?? '';
    String blocInfo = apartment.bloc?.name.translate(languageCode) ?? '';
    //String houseInfo = apartment.house?.name.translate(languageCode) ?? '';
    String flatInfo =
        '${apartment.numberApartment.toString()}-${_appLocalization.flat.capitalize()}';
    return '$complex, $blocInfo, $flatInfo';
  }
}
