import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/invoice_extension.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/main.dart';
import 'package:provider/src/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/data_source/remote_source/app_remote_source.dart';

class InvoiceFlatCard extends StatefulWidget {
  final Invoice invoice;

  const InvoiceFlatCard({
    Key? key,
    required this.invoice,
  }) : super(key: key);

  @override
  State<InvoiceFlatCard> createState() => _InvoiceFlatCardState();
}

class _InvoiceFlatCardState extends State<InvoiceFlatCard> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        Apartment apartment = state.user!.getActiveApartment();
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
              width: AppConfig.screenWidth(context),
              height: 160,
              decoration: BoxDecoration(
                image: apartment.backgroundLogo != null &&
                        apartment.backgroundLogo!.path != null
                    ? DecorationImage(
                    image: NetworkImage('${AppRemoteSourceImpl.BASE_URL}/file/download/${apartment.backgroundLogo!.guid}.${apartment.backgroundLogo!.extension}'),
                       fit: BoxFit.cover)
                    : DecorationImage(
                        image:
                            AssetImage('assets/images/apartment_default.png'),
                        fit: BoxFit.cover),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: apartment.depositSum >= widget.invoice.amount! &&
                          widget.invoice.invoiceStatus != null &&
                          widget.invoice.invoiceStatus!.isOpen()
                      ? AppColor.defaultApartmentGradient()
                      : AppColor.loanApartmentGradient(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _initBalance(apartment),
                    const Spacer(),
                    _initTopToBalance()
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget _initComplexIcon(String? path) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: path!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _initBalance(Apartment apartment) {
    String balanceTitle;
    var balansColor;
    if (apartment.depositSum >= widget.invoice.amount! &&
        widget.invoice.invoiceStatus != null &&
        widget.invoice.invoiceStatus!.isOpen()) {
      balanceTitle = _appLocalization.apartment_balance;
      balansColor = Colors.white.withOpacity(0.5);
    } else {
      balanceTitle = _appLocalization.balance_not_have_amount;
      balansColor = Color.fromRGBO(255, 194, 122, 1);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(balanceTitle.capitalize(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: balansColor, fontSize: 12.sf(context))),
              AppDimension.verticalSize_4,
              Text(
                '${apartment.depositSum.toInt().currencyFormat()} ${_appLocalization.sum}',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.white, fontSize: 16.sf(context)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )
            ],
          ),
        ),
        AppDimension.horizontalSize_16,
        _initComplexIcon(apartment.logo!.path!)
      ],
    );
  }

  Widget _initTopToBalance() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouteName.replenishBalanceScreen)
            .then((value) {
          if (value != null && value == true) {
            context.read<ProfileCubit>().getProfile();
          }
        });
      },
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.stateStatus == StateStatus.success) {
            context.read<AppCubit>().updateUser(user: state.user!);
          } else if (state.stateStatus == StateStatus.failure) {
            MyApp.failureHandling(context, state.failure!);
          }
        },
        child: Row(
          children: [
            Text(
              _appLocalization.top_up_balance.capitalize(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.white, fontSize: 16.sf(context)),
            ),
            const Spacer(),
            SvgPicture.asset('assets/icons/right.svg')
          ],
        ),
      ),
    );
  }
}
