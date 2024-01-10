import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/component/invoice_flat_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/feature/presentation/screen/invoice/component/invoice_card_component.dart';
import 'package:resident/main.dart';

import '../../component/app_modal_bottom_sheet.dart';
import '../../component/succesfull_bottom_sheet.dart';

class InvoiceScreen extends StatefulWidget {
  static Route<dynamic> route(Invoice invoice) {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<InvoiceCubit>()),
          BlocProvider(create: (_) => getIt<PayInvoiceCubit>()),
        ],
        child: InvoiceScreen(invoice: invoice),
      );
    });
  }

  final Invoice invoice;

  const InvoiceScreen({Key? key, required this.invoice}) : super(key: key);

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late final AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
    context.read<InvoiceCubit>().getInvoiceById(
        context.read<AppCubit>().getActiveApartment().id, widget.invoice.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit, InvoiceState>(
        listener: (context, invoiceState) {
      if (invoiceState.stateStatus == StateStatus.failure) {
        MyApp.failureHandling(context, invoiceState.failure!);
      }
    }, builder: (context, invoiceState) {
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_third_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
              ),
              backgroundColor: Colors.transparent,
              leadingWidth: 0,
              titleSpacing: 0,
              title: CustomAppBar(
                label: '№ ${widget.invoice.invoice ?? ''}',
              ),
            ),
            body: _initBody(invoiceState)),
      );
    });
  }

  Widget _initBody(InvoiceState invoiceState) {
    if (invoiceState.stateStatus == StateStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (invoiceState.stateStatus == StateStatus.success) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            InvoiceCardComponent(invoice: invoiceState.response!.data!),
            AppDimension.verticalSize_16,
            invoiceState.response!.data!.invoiceStatus!.toLowerCase() ==
                    'closed'
                ? const SizedBox()
                : InvoiceFlatCard(
                    invoice: widget.invoice,
                  ),
            const Spacer(),
            AppDimension.verticalSize_16,
            _initButtons(invoiceState.response!.data!)
          ],
        ),
      );
    }
    return const SizedBox();
  }

  Widget _initButtons(Invoice invoice) {
    if (invoice.invoiceStatus!.toLowerCase() == 'closed' ||
        invoice.invoiceStatus!.toLowerCase() == 'canceled') {
      return ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(_appLocalization.close.toUpperCase(),style: TextStyle(fontSize: 14.sf(context))));
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: AppColor.c60000),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(_appLocalization.cancel.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)))),
        ),
        AppDimension.horizontalSize_8,
        Expanded(
          child: BlocConsumer<PayInvoiceCubit, PayInvoiceState>(
            listener: (context, state) {
              if (state.stateStatus == StateStatus.success) {
               // Navigator.of(context).pop(true);
_openSuccessBottomSheet(context);
                // showSuccessFlushBar(context, state.response!.statusMessage.translate(context
                //     .read<LanguageCubit>()
                //     .state
                //     .languageCode) ??
                //     '');
              } else if (state.stateStatus == StateStatus.failure) {
                MyApp.failureHandling(context, state.failure!);
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                  onPressed: context
                                  .read<AppCubit>()
                                  .state
                                  .user!
                                  .getActiveApartment()
                                  .depositSum >=
                              widget.invoice.amount! &&
                          widget.invoice.invoiceStatus != null &&
                          widget.invoice.invoiceStatus!.isOpen()
                      ? () {
                          context
                              .read<PayInvoiceCubit>()
                              .payInvoice(context.read<AppCubit>().getActiveApartment().id, widget.invoice.id!);
                        }
                      : null,
                  child: state.stateStatus == StateStatus.loading
                      ? const CupertinoActivityIndicator(radius: 12)
                      : Text(
                          _appLocalization.pay.toUpperCase(),style: TextStyle(fontSize: 14.sf(context))
                        ));
            },
          ),
        )
      ],
    );
  }
  _openSuccessBottomSheet(BuildContext subContext) {
    showAppModalBottomSheet(
        context: context,
        enableDrag: false,
        builder: (context) {
          return SuccessfulBottomSheet(
            description: _appLocalization.paid_successfully,
            subContext: subContext,
            isAdd: 2,
          );
        }).then((value) {
      context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
      print("value1$value");
      Navigator.pop(subContext, value);
    });
  }
}
