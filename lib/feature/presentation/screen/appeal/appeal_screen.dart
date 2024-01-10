import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_arrow_card.dart';
import 'package:resident/feature/presentation/screen/appeal/component/appeal_list_component.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import '../../../domain/entity/response/appeal_type.dart';

class AppealScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return BlocProvider(
        create: (_) => getIt<AppealCubit>(),
        child: const AppealScreen(),
      );
    });
  }

  const AppealScreen({Key? key}) : super(key: key);

  @override
  State<AppealScreen> createState() => _AppealScreenState();
}

class _AppealScreenState extends State<AppealScreen> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/part_third_gradient.png',
              ),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, isHeaderSliverBuilder) {
              return [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 208,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 4,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Theme.of(context)
                                    .primaryColor, shape: const CircleBorder(), backgroundColor: Colors.white,
                                fixedSize: const Size(32, 32),
                                elevation: 0, // <-- Splash color
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/icons/left_app_bar.svg'),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 24,
                          right: 24,
                          bottom: 0,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Theme.of(context).primaryColor, fixedSize: const Size(64, 64), backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    elevation: 0,
                                  ),
                                  child:
                                      SvgPicture.asset('assets/icons/send.svg'),
                                ),
                                AppDimension.verticalSize_16,
                                Text(
                                  _appLocalization.appeal.capitalize(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          color: AppColor.c4000, fontSize: 17.sf(context)),
                                ),
                                AppDimension.verticalSize_24,
                                BlocBuilder<AppealCubit, AppealState>(
  builder: (context, state) {
    return AppArrowCard(
                                  label: _appLocalization.history_appeal
                                      .capitalize(),
                                  labelColor: Colors.white,
                                  bgColor: AppColor.c6000,
                                  onPressed: () {
                                    _openScreen(
                                        AppRouteName.appealHistoryScreen,state.response!.data);
                                  },
                                );
  },
)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: const AppealListComponent(),
          ),
        ),
      ),
    );
  }

  void _openScreen(String routeName, List<AppealType>? appealTypes) {
    Navigator.pushNamed(context, routeName,arguments: appealTypes);
  }
}
