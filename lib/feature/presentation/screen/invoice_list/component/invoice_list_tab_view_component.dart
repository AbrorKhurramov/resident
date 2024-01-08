import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/component/invoice_status_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InvoiceListTabViewComponent extends StatefulWidget {




  static BlocProvider<InvoiceListCubit> initInvoiceTabViewComponent(
   {Key? key,int? status,
     int? type,
     String? dateFrom, String? dateTo, String? id}) {
    return BlocProvider(
      create: (_) {
        return getIt<InvoiceListCubit>();
      },
      child: InvoiceListTabViewComponent(dateFrom:dateFrom, dateTo: dateTo, id: id,status: status,type:type, key: key),
    );
  }
  int? status;
  int? type;
  final String? dateFrom;
  final String? dateTo;
  final String? id;


   InvoiceListTabViewComponent(
      {Key? key,this.status,this.type, required this.dateFrom, required this.dateTo, required this.id})
      : super(key: key);

  @override
  State<InvoiceListTabViewComponent> createState() =>
      _InvoiceListTabViewComponentState();
}

class _InvoiceListTabViewComponentState
    extends State<InvoiceListTabViewComponent>
    with AutomaticKeepAliveClientMixin {
  late AppLocalizations _appLocalization;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<InvoiceListCubit>().getInvoiceList(
        context.read<AppCubit>().state.user!.getActiveApartment().id,
      widget.status,
      widget.type,
      widget.dateFrom.toString(),
      widget.dateTo.toString()
    );
    print("apart ${widget.status}  ${widget.id}");
    print(context.read<AppCubit>().state.user!.getActiveApartment().id);
    _appLocalization = AppLocalizations.of(context)!;
    if(widget.id!=null){
      context.read<InvoiceListCubit>().updateInvoiceColor(true);
    }
    else {
      context.read<InvoiceListCubit>().updateInvoiceColor(false);
    }
  }

  void _getInvoice() async {
    _refreshIndicatorKey.currentState!.show();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);



    return BlocBuilder<InvoiceListCubit, InvoiceListState>(
        buildWhen: (oldState, newState) {

          return true;
        },
        builder: (context, state) {
      if (state.stateStatus == StateStatus.initial) {
        return Container();
      }
      if (state.stateStatus == StateStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      BasePaginationListResponse<Invoice> response = state.response!;
      if (response.data.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              AppDimension.verticalSize_16,
              AppEmptyCard(
                  path: 'assets/icons/empty_invoice.svg',
                  description: _appLocalization.empty_invoice_description)
            ],
          ),
        );
      }

      return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          context.read<InvoiceListCubit>().getInvoiceList(
              context.read<AppCubit>().state.user!.getActiveApartment().id,
            widget.status,
            widget.type,
            widget.dateFrom.toString(),
            widget.dateTo.toString(),
              );
        },
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemBuilder: (context, index) {

            if (response.currentPage + 1 != response.totalPages &&
                index == response.data.length) {
              if (state.stateStatus != StateStatus.paginationLoading) {
                context.read<InvoiceListCubit>().getPaginationInvoiceList(
                    context
                        .read<AppCubit>()
                        .state
                        .user!
                        .getActiveApartment()
                        .id,
                    response.currentPage + 1,
                  widget.dateFrom.toString(),
                  widget.dateTo.toString(),
                widget.status,
                  widget.type
                );
              }

              return const Center(child: CircularProgressIndicator());
            }

            return Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  color: Colors.white.withOpacity(0.95)),
              child: _initItem(
                response.data[index],
                state.isNotification,
                () {
                  context.read<InvoiceListCubit>().updateInvoiceColor(false);
                  BlocProvider<ProfileCubit>(
                      create: (context) => getIt<ProfileCubit>());
                  Navigator.pushNamed(context, AppRouteName.invoiceScreenItem,
                          arguments: response.data[index])
                      .then((value) => {if (value == true) _getInvoice()});
                },widget.id
              ),
            );
          },
          separatorBuilder: (context, item) {
            return AppDimension.verticalSize_12;
          },
          itemCount: response.currentPage + 1 < response.totalPages
              ? response.data.length + 1
              : response.data.length,
        ),
      );
    });
  }

  Widget _initItem(
      Invoice invoice, bool? isNotification, GestureTapCallback? onTap,String? id) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: isNotification==true&&widget.id==invoice.id
                ? Colors.red.withOpacity(0.2)
                : Colors.white.withOpacity(0.95),
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _initItemHeader(invoice.invoiceService.isEmpty
                ? null
                : invoice.invoiceService[0]),
            _initAmount(invoice.amount ?? 0),
            InvoiceStatusComponent(invoice: invoice),
            AppDimension.verticalSize_12,
            _initNumberAndDate(invoice)
          ],
        ),
      ),
    );
  }

  Widget _initItemHeader(InvoiceService? invoiceService) {
    if (invoiceService == null) {
      return AppDimension.defaultSize;
    }

    late String iconPath;
    late String message;

    if (invoiceService.type == null) {
      iconPath = 'assets/icons/others.svg';
      message = _appLocalization.others.capitalize();
    }

    switch (invoiceService.type) {
      case 'COOL_WATER':
        iconPath = 'assets/icons/cold_water.svg';
        message = _appLocalization.cold_water.capitalize();
        break;
      case 'HOT_WATER':
        iconPath = 'assets/icons/hot_water.svg';
        message = _appLocalization.hot_water.capitalize();
        break;
      case 'ELECTRICITY':
        iconPath = 'assets/icons/light.svg';
        message = _appLocalization.electricity.capitalize();
        break;
      case 'GAS':
        iconPath = 'assets/icons/gas.svg';
        message = _appLocalization.gas.capitalize();
        break;
      default:
        iconPath = 'assets/icons/others.svg';
        message = _appLocalization.others.capitalize();
        break;
    }

    return Row(
      children: [
        SvgPicture.asset(iconPath),
        AppDimension.horizontalSize_8,
        Text(
          message,
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: AppColor.c4000, fontSize: 10.sf(context),
        )),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: AppColor.c6000),
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Widget _initAmount(int amount) {
    return Text(
      '${amount.currencyFormat()} ${_appLocalization.sum}',
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(color: AppColor.c4000, fontSize: 28.sf(context)),
    );
  }

  Widget _initNumberAndDate(Invoice invoice) {
    if (invoice.createdDate == null) {
      return AppDimension.defaultSize;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _appLocalization.invoice_number.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppColor.c3000, fontSize: 10.sf(context)),
            ),
            Text(
              invoice.invoice ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
            ),
          ],
        ),
        const Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _appLocalization.date_of_issue.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: AppColor.c3000, fontSize: 10.sf(context)),
            ),
            Text(
    invoice.createdDate!.getDateWithHour(_appLocalization),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: AppColor.c4000, fontSize: 10.sf(context)),
            ),
          ],
        )
      ],
    );
  }
}
