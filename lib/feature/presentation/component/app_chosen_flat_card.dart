import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/data_source/remote_source/app_remote_source.dart';

class AppChosenFlatCard extends StatefulWidget {
  final Apartment apartment;

  const AppChosenFlatCard({Key? key, required this.apartment})
      : super(key: key);

  @override
  State<AppChosenFlatCard> createState() => _AppChosenFlatCardState();
}

class _AppChosenFlatCardState extends State<AppChosenFlatCard> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Container(
          width: AppConfig.screenWidth(context),
          height: 160,
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColor.defaultApartmentGradient(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _initHeader(widget.apartment.complex!,widget.apartment.type),
                    const Spacer(),
                    _initComplexIcon(widget.apartment.logo!.path!),
                  ],
                ),
                _initBalance(widget.apartment.depositSum.toInt()),
                const Spacer(),
                _initPersonalAccount()
              ],
            ),
          )),
    );
  }

  Widget _initHeader(Complex complex,int type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(complex.name,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12.sf(context))),
        Text(
          widget.apartment.getApartmentInfo(
              context.read<LanguageCubit>().languageCode(),
              type==1?  _appLocalization.flat.capitalize():_appLocalization.office.capitalize()),
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Colors.white, fontSize: 16.sf(context)),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _initComplexIcon(String? path) {
    return Container(
      width: 50,
      height: 50,
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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRouteName.replenishBalanceScreen)
                .then((value) {
              if (value != null && value == true) {
                context.read<ProfileCubit>().getProfile();
              }
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(_appLocalization.apartment_balance.capitalize(),
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Colors.white.withOpacity(0.5), fontSize: 12.sf(context))),
              ),
              AppDimension.verticalSize_4,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 20,
                      height: 20,
                      child:
                      // profileState.stateStatus == StateStatus.loading
                      //     ? SizedBox(
                      //         width: 8,
                      //         height: 8,
                      //         child: CircularProgressIndicator(
                      //             color: Colors.white),
                      //       )
                      //     :
                      Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: AppColor.c4000,
                                  size: 16,
                                ),
                              ),
                            )),
                  AppDimension.horizontalSize_8,
                  Text(
                    '${balance.currencyFormat()} ${_appLocalization.sum}',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.white, fontSize: 25.sf(context)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _initPersonalAccount() {
    return BlocSelector<AppCubit, AppState, String>(selector: (state) {
      print("APP STATE");
      print(state.toString());
      return state.user!.getActiveApartment().account ?? '';
    }, builder: (context, state) {
      print('_initPersonalAccount');
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
                  .displaySmall!
                  .copyWith(color: Colors.white.withOpacity(0.5), fontSize: 12.sf(context)),
            ),
            AppDimension.horizontalSize_8,
            Text(state,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white, fontSize: 12.sf(context))),
          ],
        ),
      );
    });
  }
}
