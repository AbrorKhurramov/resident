import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/data_source/remote_source/app_remote_source.dart';

class AppFlatCard extends StatefulWidget {
  final Apartment apartment;

  const AppFlatCard({
    Key? key,
    required this.apartment,
  }) : super(key: key);

  @override
  State<AppFlatCard> createState() => _AppFlatCardState();
}

class _AppFlatCardState extends State<AppFlatCard> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
          width: AppConfig.screenWidth(context),
          height: 216,
          decoration: BoxDecoration(
            image: widget.apartment.backgroundLogo != null &&
                    widget.apartment.backgroundLogo!.path != null
                ? DecorationImage(
                    image: NetworkImage('${AppRemoteSourceImpl.BASE_URL}/file/download/${widget.apartment.backgroundLogo!.guid}.${widget.apartment.backgroundLogo!.extension}'),
                    fit: BoxFit.cover)
                : const DecorationImage(
                    image: AssetImage('assets/images/apartment_default.png'),
                    fit: BoxFit.cover),
          ),
          child: Container(
            width: AppConfig.screenWidth(context),
            height: 216,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(
                color: widget.apartment.selected!
                    ? AppColor.c6000
                    : Colors.transparent,
                width: 4,
              ),
              gradient: AppColor.defaultApartmentGradient(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _initBalance(widget.apartment.depositSum.toInt()),
                        AppDimension.verticalSize_8,
                        _initPersonalAccount(widget.apartment.account ?? ''),
                      ],
                    ),
                    const Spacer(),
                    _initComplexIcon(widget.apartment.logo!.path!),
                  ],
                ),
                AppDimension.verticalSize_16,
                _initComplex(widget.apartment.complex!),
                const Spacer(),
                _initFlatInfo(
                  widget.apartment.house!,
                  widget.apartment.floor!,
                  widget.apartment.numberApartment,
                  widget.apartment.type
                )
              ],
            ),
          )),
    );
  }

  Widget _initComplex(Complex complex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(_appLocalization.residential_complex.capitalize(),
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12.sf(context))),
        Text(
          complex.name,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white, fontSize: 16.sf(context)),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _initComplexIcon(String? path) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: path!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _initBalance(int balance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(_appLocalization.apartment_balance.capitalize(),
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12.sf(context))),
        Text(
          '${balance.currencyFormat()} ${_appLocalization.sum}',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white, fontSize: 25.sf(context)),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _initPersonalAccount(String personalAccount) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.black.withOpacity(0.3)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${_appLocalization.personal_account.capitalize()}:',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12.sf(context)),
          ),
          AppDimension.horizontalSize_8,
          Text(personalAccount,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: Colors.white, fontSize: 12.sf(context))),
        ],
      ),
    );
  }

  Widget _initFlatInfo(House house, Floor floor, int numberApartment,int type) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: _initInfo(
              'assets/icons/house.svg',
              _appLocalization.house.capitalize(),
              house.name.translate(
                      context.read<LanguageCubit>().state.languageCode) ??
                  ''),
        ),
        Expanded(
          flex: 1,
          child: _initInfo(
              'assets/icons/floor.svg',
              _appLocalization.floor.capitalize(),
              floor.name.translate(
                      context.read<LanguageCubit>().state.languageCode) ??
                  ''),
        ),
        Expanded(
          flex: 1,
          child: _initInfo('assets/icons/key.svg',
            type==1?  _appLocalization.flat.capitalize():_appLocalization.office.capitalize(), numberApartment.toString()),
        )
      ],
    );
  }

  Widget _initInfo(String iconPath, String title, String subTitle) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(iconPath),
        AppDimension.horizontalSize_4,
        Flexible(
          child: Column(
            children: [
              Text(
                title,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Colors.white, fontSize: 10.sf(context)),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subTitle,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 12.sf(context)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
