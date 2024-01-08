import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/component/app_empty_card.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/service_component/component/service_menu_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../bloc/app_cubit/app_cubit.dart';
import '../../../../bloc/counter_cubit/counter_cubit.dart';
import '../../../../bloc/news_cubit/news_cubit.dart';
import '../../../../bloc/profile_cubit/profile_cubit.dart';

class ServiceComponent extends StatefulWidget {
  const ServiceComponent({Key? key}) : super(key: key);

  @override
  State<ServiceComponent> createState() => _ServiceComponentState();
}

class _ServiceComponentState extends State<ServiceComponent>
    with AutomaticKeepAliveClientMixin {
  late AppLocalizations _appLocalization;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return RefreshIndicator(
      onRefresh: () async{
       await context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
       await context.read<CounterCubit>().getCounterList(context.read<AppCubit>().getActiveApartment().id);
       await context.read<NewsCubit>().getNews(0);
      },
      child: SingleChildScrollView(
        child: Container(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/part_third.png',
                  ),
                  fit: BoxFit.fill),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 26),
                  AppDimension.verticalSize_16,
                  const ServiceMenuComponent(),
                  AppDimension.verticalSize_24,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AppEmptyCard(
                        path: 'assets/icons/empty_service_card.svg',
                        description: _appLocalization.empty_service_description),
                  ),
                  // ServiceNotificationComponent(),
                  // ServiceListComponent(),
                ],
              ),
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
