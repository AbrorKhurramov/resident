import 'package:flutter/material.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:provider/src/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReplenishBalanceEmptyComponent extends StatefulWidget {
  const ReplenishBalanceEmptyComponent({Key? key}) : super(key: key);

  @override
  State<ReplenishBalanceEmptyComponent> createState() => _ReplenishBalanceEmptyComponentState();
}

class _ReplenishBalanceEmptyComponentState extends State<ReplenishBalanceEmptyComponent> {
  late AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    _appLocalization = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AppEmptyCard(
              path: 'assets/icons/empty_replenish_card.svg',
              description:
              _appLocalization.empty_replenish_balance_description.capitalize()),
          AppDimension.verticalSize_16,
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouteName.myCardScreen)
                  .then((value) {
                context.read<CardCubit>().getCardList();
              });
            },
            child: Text(
              _appLocalization.add_card.toUpperCase(),
              style: TextStyle(fontSize: 14.sf(context)
              ),
            ),
          ),
          AppDimension.verticalSize_32
        ],
      ),
    );
  }
}
