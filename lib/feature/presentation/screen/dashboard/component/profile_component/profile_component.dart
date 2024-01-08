import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/app_arrow_card.dart';
import 'package:resident/feature/presentation/component/app_chosen_flat_card.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/language_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/log_out_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/notification_component.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/profile_component/component/user_info_component.dart';
import 'package:resident/injection/injection_container.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../component/language_arrow_card.dart';
import '../../../login/component/support_bottom_sheet.dart';

class ProfileComponent extends StatefulWidget {
  const ProfileComponent({Key? key}) : super(key: key);

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> with AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  late AppLocalizations _appLocalization = AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getProfile();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
  }

  void _getProfile() async {
    _refreshIndicatorKey.currentState!.show();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/part_first.png',
            ),
            fit: BoxFit.fill),
      ),
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await  context.read<ProfileCubit>().getProfile();
          await context.read<ProfileCubit>().getFirebaseNotificationState();
        await context.read<ProfileCubit>().getNotificationsCount(context.read<AppCubit>().getActiveApartment().id);
      //  await context.read<CounterCubit>().getCounterList(context.read<AppCubit>().getActiveApartment().id);
       // await  context.read<NewsCubit>().getNews(0);
        },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 56),
                  AppDimension.verticalSize_32,
                  const UserInfoComponent(),
                  AppDimension.verticalSize_32,
                  BlocConsumer<AppCubit, AppState>(
                    buildWhen: (oldState, newState) {
                      return true;
                    },
                    listener: (context, appState) {},
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteName.myFlatScreen);
                        },
                        child: AppChosenFlatCard(
                          apartment: state.user!.getActiveApartment(),
                        ),
                      );
                    },
                  ),
                  AppDimension.verticalSize_16,
                  NotificationComponent(label: _appLocalization.notifications.capitalize()),
                  AppDimension.verticalSize_16,
                  LanguageArrowCard(
                    label: _appLocalization.language.capitalize(),
                    desc: _getDefaultLanguageLabel(context.read<LanguageCubit>().state.languageCode),
                    onPressed: () {
                      showAppModalBottomSheet(
                          context: context,
                          isExpand: true,
                          builder: (context) {
                            return const LanguageBottomSheet();
                          });
                    },
                  ),
                  AppDimension.verticalSize_16,
                  AppArrowCard(label: _appLocalization.my_card.capitalize(), onPressed: _onPressedMyCard),
                  AppDimension.verticalSize_16,
                  AppArrowCard(
                      label: _appLocalization.replenishment_history.capitalize(), onPressed: _onPressedPaymentHistory),
                  AppDimension.verticalSize_16,
                  AppArrowCard(label: _appLocalization.top_up_balance.capitalize(), onPressed: _onPressedReplenishment),
                  AppDimension.verticalSize_16,
                  AppArrowCard(label: _appLocalization.security.capitalize(), onPressed: _onPressedSecurity),
                  AppDimension.verticalSize_16,
                  AppArrowCard(label: _appLocalization.support.capitalize(), onPressed: _onPressedSupport),
                  AppDimension.verticalSize_16,
                  AppArrowCard(label: _appLocalization.documents.capitalize(), onPressed: _onPressedDocument),
                  AppDimension.verticalSize_16,
                  AppArrowCard(label: _appLocalization.log_out.capitalize(), onPressed: _onPressedLogOut),
                  AppDimension.verticalSize_16,
                ],
              ),
            ),
          ),

      ),
    );
  }

  void _onPressedMyCard() {
    Navigator.pushNamed(context, AppRouteName.myCardScreen);
  }

  void _onPressedPaymentHistory() {
    Navigator.pushNamed(context, AppRouteName.paymentHistoryScreen);
  }

  void _onPressedReplenishment() {
    Navigator.pushNamed(context, AppRouteName.replenishBalanceScreen).then((value) {
      if (value != null && value == true) {
        _getProfile();
      }
    });
  }

  void _onPressedSecurity() {
    Navigator.pushNamed(context, AppRouteName.securitySettingsScreen).then((value) {
      if (value != null && value == true) {
        _getProfile();
      }
    });
  }

  void _onPressedDocument() {
    Navigator.pushNamed(context, AppRouteName.documentScreen);
  }
  void _onPressedSupport() {
    showAppModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider(
              create: (_) => getIt<SupportCubit>(),
              child: SupportBottomSheet(isLogin: true));
        });
  }

  _getDefaultLanguageLabel(String sysLang) {
    switch (sysLang) {
      case LanguageConst.english:
        return _appLocalization.en;
      case LanguageConst.russian:
        return _appLocalization.ru;
      default:
        return _appLocalization.uz;
    }
  }

   _onPressedLogOut() {
    showAppModalBottomSheet(
        context: context,
        isExpand: true,
        builder: (context) {
          return const LogOutBottomSheet();
        }).then((value) {
      if (value != null && value) {
        context.read<CounterCubit>().setInitial();
        MyApp.logOut(context);
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
