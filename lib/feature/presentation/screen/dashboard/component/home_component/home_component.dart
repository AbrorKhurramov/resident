import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_chosen_flat_card.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/home_component/component/app_communal_list.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/home_component/component/app_news.dart';
import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeComponent extends StatefulWidget {
  const HomeComponent({Key? key}) : super(key: key);

  @override
  State<HomeComponent> createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorHomeKey = GlobalKey<RefreshIndicatorState>();

  late  AppLocalizations _appLocalization ;



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // _getHome();
    });
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;

  }
  void _getHome() async {
    _refreshIndicatorHomeKey.currentState!.show();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/part_second.png',
            ),
            fit: BoxFit.fill),
      ),
      child: RefreshIndicator(
        key: _refreshIndicatorHomeKey,
        onRefresh: () async{
        await  context.read<ProfileCubit>().getProfile();
        await  context.read<CounterCubit>().getCounterList(context.read<AppCubit>().getActiveApartment().id);
        await  context.read<NewsCubit>().getNews(0);
        },
        child: ListView(
    children: [
    AppDimension.verticalSize_32,
    BlocBuilder<AppCubit, AppState>(builder: (context, state) {
    return _initUserLabel(state.user!.firstName);
    }),
    AppDimension.verticalSize_16,
   AppNews(),
    AppDimension.verticalSize_16,
    BlocConsumer<AppCubit, AppState>(
      buildWhen: (oldState, newState) {
           return true;
        },
    listener: (context, appState) {},
    builder: (context, state) {
    return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: AppChosenFlatCard(
    apartment: state.user!.getActiveApartment(),
    ),
    );
    },
    ),
    AppDimension.verticalSize_16,

    AppCommunalList(),


    AppDimension.verticalSize_16,
    ],
    ),
      ),

    );
  }

  Widget _initUserLabel(String? name) {
    return Text(
      '${_appLocalization.good_day.toUpperCase()}\n$name',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontSize: 18.sf(context), color: AppColor.c4000, letterSpacing: 0.6),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
