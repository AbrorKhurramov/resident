import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/custom_app_bar.dart';
import 'package:resident/feature/presentation/screen/replenish_balance/component/replenish_balance_component.dart';
import 'package:resident/feature/presentation/screen/replenish_balance/component/replenish_balance_empty_component.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReplenishBalanceScreen extends StatefulWidget {
  const ReplenishBalanceScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(providers: [
        BlocProvider(create: (_) => getIt<CardCubit>()),
        BlocProvider(create: (_) => getIt<ReplenishmentCubit>()),
        BlocProvider(create: (_) => getIt<ReplenishmentDetailsCubit>()),

      ], child: const ReplenishBalanceScreen());
    });
  }

  @override
  State<ReplenishBalanceScreen> createState() => _ReplenishBalanceScreenState();
}

class _ReplenishBalanceScreenState extends State<ReplenishBalanceScreen> {
  late final AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CardCubit>().getCardList();
    context.read<ReplenishmentDetailsCubit>().getReplenishmentDetails(context.read<AppCubit>().getActiveApartment().id);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/part_first_gradient.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: RefreshIndicator(
                onRefresh: () async{
                  await  context.read<ProfileCubit>().getProfile();
                },
                child: ListView(
                  children: [
                    CustomAppBar(
                        label: _appLocalization.top_up_balance.capitalize()),
                    BlocConsumer<CardCubit, CardState>(listener: (context, state) {
                      if (state.stateStatus == StateStatus.failure) {
                        MyApp.failureHandling(context, state.failure!);
                      }
                    }, builder: (context, cardState) {
                      if (cardState.stateStatus == StateStatus.success &&
                          cardState.response!.data.isEmpty) {
                        return const ReplenishBalanceEmptyComponent();
                      } else if (cardState.stateStatus == StateStatus.success &&
                          cardState.response!.data.isNotEmpty) {
                        return const ReplenishBalanceComponent();
                      }
                      return const SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
        // RefreshIndicator(
        //   onRefresh: () async{
        //
        //   },
        //
        //
        //   // child: CustomScrollView(
        //   //   slivers: [
        //   //     SliverFillRemaining(
        //   //
        //   //     )
        //   //   ],
        //   //
        //   // ),
        // ),
    );
  }
}
