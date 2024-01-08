import 'package:resident/core/extension/size_extension.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/app_failure.dart';
import 'package:resident/feature/presentation/component/app_arrow_card.dart';
import 'package:resident/feature/presentation/component/app_loading.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/custom_sliver_app_bar.dart';
import 'package:resident/feature/presentation/screen/my_card/component/add_card_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/card_component.dart';
import 'package:resident/feature/presentation/screen/my_card/component/delete_card_bottom_sheet.dart';
import 'package:resident/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyCardScreen extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) {
      return MultiBlocProvider(providers: [
        BlocProvider(create: (_) => getIt<CardCubit>()),
        BlocProvider(create: (_) => getIt<MyCardCubit>())
      ], child: const MyCardScreen());
    });
  }

  const MyCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen> {
  late AppLocalizations _appLocalization;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CardCubit>().getCardList();
    _appLocalization = AppLocalizations.of(context)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/part_first_gradient.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<CardCubit>().getRefreshList();
          },
          child: SafeArea(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  CustomSliverAppBar(label: _appLocalization.my_card.capitalize()),
                ];
              },
              body: BlocConsumer<CardCubit, CardState>(
                listener: (context, cardState) {
                  if (cardState.stateStatus == StateStatus.failure) {
                    MyApp.failureHandling(context, cardState.failure!);
                  }
                },
                builder: (context, cardState) {
                  switch (cardState.stateStatus) {
                    case StateStatus.loading:
                      return const AppLoading();
                    case StateStatus.failure:
                      return AppFailure(failure: cardState.failure!);
                    case StateStatus.success:
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            AppDimension.verticalSize_16,
                            cardState.response!.data.isNotEmpty
                                ? CardComponent(cardResponse: cardState.response!.data[0])
                                : const CardComponent(),
                            AppDimension.verticalSize_24,
                            cardState.response!.data.isNotEmpty
                                ? _initRemoveCardButton(cardState.response!.data[0])
                                : _initAddCardButton(context)
                          ],
                        ),
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _initRemoveCardButton(CardResponse cardResponse) {
    return BlocConsumer<MyCardCubit, MyCardState>(
      listener: (context, state) {
        if (state.stateStatus == StateStatus.success) {
          context.read<CardCubit>().getCardList();
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            showAppModalBottomSheet(
                context: context,
                isExpand: true,
                builder: (context) {
                  return const DeleteCardBottomSheet();
                }).then((value) {
              if (value != null && value) {
                context.read<MyCardCubit>().deleteCard(cardResponse);
                showSuccessFlushBar(context, _appLocalization.card_delete_successfully.capitalize());
              }
            });
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              fixedSize: const Size(double.infinity, 64),
              onPrimary: Colors.blue,
              primary: Colors.white,
              elevation: 0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  _appLocalization.delete_card.capitalize(),
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: AppColor.c50000, fontSize: 14.sf(context)),
                ),
                SvgPicture.asset(
                  'assets/icons/trash.svg',
                  color: AppColor.c50000,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _initAddCardButton(BuildContext subContext) {
    return AppArrowCard(label: _appLocalization.add_card.capitalize(), onPressed:() {
    showAppModalBottomSheet(
    context: context,
    builder: (context) {
    return BlocProvider(
    create: (_) => getIt<AddCardCubit>(),
    child: AddCardBottomSheet(subContext: subContext),
    );
    }).then((value) {
    if (value != null && value) {
    context.read<CardCubit>().getCardList();
    }
    });
    });
  }

  void _onAddCard(BuildContext subContext) {

  }
}
