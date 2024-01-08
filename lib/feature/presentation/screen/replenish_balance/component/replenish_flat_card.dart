import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:provider/src/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../data/data_source/remote_source/app_remote_source.dart';

class ReplenishFlatCard extends StatefulWidget {
  final Apartment apartment;

  const ReplenishFlatCard({
    Key? key,
    required this.apartment,
  }) : super(key: key);

  @override
  State<ReplenishFlatCard> createState() => _ReplenishFlatCardState();
}

class _ReplenishFlatCardState extends State<ReplenishFlatCard> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
          width: AppConfig.screenWidth(context),
          height: 160,
          decoration: BoxDecoration(
            image: widget.apartment.backgroundLogo != null &&
                    widget.apartment.backgroundLogo!.path != null
                ? DecorationImage(
                    image:
                        NetworkImage('${AppRemoteSourceImpl.BASE_URL}/file/download/${widget.apartment.backgroundLogo!.guid}.${widget.apartment.backgroundLogo!.extension}'),
                    fit: BoxFit.cover)
                : const DecorationImage(
                    image: AssetImage('assets/images/apartment_default.png'),
                    fit: BoxFit.cover),
          ),
          child: Container(
            width: AppConfig.screenWidth(context),
            height: 160,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColor.defaultApartmentGradient(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _initHeader(widget.apartment.complex!),
                const Spacer(),
                _initPersonalAccount(widget.apartment.depositSum.toInt())
              ],
            ),
          )),
    );
  }

  Widget _initHeader(Complex complex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(complex.name,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12)),
        Text(
          '${widget.apartment.bloc!.name.translate(context.read<LanguageCubit>().state.languageCode)}, ${widget.apartment.house!.name.translate(context.read<LanguageCubit>().state.languageCode)}',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white, fontSize: 16),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _initComplexIcon(String path) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: path,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _initPersonalAccount(int balance) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_appLocalization.apartment_balance.capitalize()}:',
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12),
            ),
            AppDimension.horizontalSize_8,
            Text('${balance.currencyFormat()} ${_appLocalization.sum}',
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white, fontSize: 20)),
          ],
        ),
        const Spacer(),
        _initComplexIcon(widget.apartment.logo!.path!),
      ],
    );
  }
}
