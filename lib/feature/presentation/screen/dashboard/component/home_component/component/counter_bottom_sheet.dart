import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/core/extension/size_extension.dart';
import 'package:resident/feature/presentation/app_route/app_route_name.dart';
import 'package:resident/feature/presentation/component/counter_chooser_component.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/home_component/component/service_result_history_component.dart';
import 'package:resident/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../core/extension/thousands_input_formatter.dart';
import '../../../../indication_history/indication_history_screen.dart';

class CounterBottomSheet extends StatefulWidget {
  final List<Counter> counter;
  final int type;


  const CounterBottomSheet({
    Key? key,
    required this.counter,
    required this.type,
  }) : super(key: key);




  @override
  State<CounterBottomSheet> createState() => _CounterBottomSheetState();
}

class _CounterBottomSheetState extends State<CounterBottomSheet> {
  late AppLocalizations _appLocalization;
  late Counter chosenCounter;
  late final TextEditingController _counterTextController;
  late bool _keyboardVisible;



  @override
  void initState() {
    _counterTextController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _counterTextController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocalization = AppLocalizations.of(context)!;
    chosenCounter = widget.counter[0];
  }

  @override
  Widget build(BuildContext context) {
    _keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SizedBox(
            width: AppConfig.screenWidth(context),
            height: AppConfig.screenHeight(context) * 0.9,
            child: BlocBuilder<AppCubit, AppState>(builder: (context, appState) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                    AppDimension.verticalSize_16,
                    Text(
                      widget.type
                          .getCommunalType()
                          .getLabel(_appLocalization)
                          .capitalize(),
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(fontSize: 17.sf(context), color: AppColor.c4000),
                    ),
                    Text(
                        context
                            .read<AppCubit>()
                            .getActiveApartment()
                            .complexInfo(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 17.sf(context), color: AppColor.c4000)),
                    Text(
                        context
                            .read<AppCubit>()
                            .getActiveApartment()
                            .getApartmentInfo(
                                context.read<LanguageCubit>().languageCode(),
                                _appLocalization.flat),
                        style: Theme.of(context)
                            .textTheme
                            .headline2!
                            .copyWith(fontSize: 17.sf(context), color: AppColor.c4000)),
                    AppDimension.verticalSize_24,
                    CounterChooserComponent(
                      counters: widget.counter,
                      onPressed: (counter) {
                        chosenCounter = counter;
                      },
                    ),
                    AppDimension.verticalSize_12,
                    _initTextField(),
                    AppDimension.verticalSize_32,
                   _keyboardVisible?ButtonWidget(appLocalization: _appLocalization): GoToHistoryScreenWidget(widget: widget, appLocalization: _appLocalization) ,
                    if(!_keyboardVisible) AppDimension.verticalSize_24,
                   if(!_keyboardVisible) ServiceResultHistoryComponent(type: widget.type,isPhysics: _keyboardVisible,),
                    AppDimension.verticalSize_32,
                    !_keyboardVisible?ButtonWidget(appLocalization: _appLocalization): GoToHistoryScreenWidget(widget: widget, appLocalization: _appLocalization) ,
                    if(_keyboardVisible) AppDimension.verticalSize_24,
                    if(_keyboardVisible) ServiceResultHistoryComponent(type: widget.type,isPhysics: _keyboardVisible),

                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _initTextField() {
    return Container(
      height: 84,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        border: Border.all(
          color: AppColor.c8000,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _appLocalization.current_indication.capitalize(),
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AppColor.c4000,
                  fontSize: 12.sf(context),
                ),
          ),
          TextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              ThousandsSeparatorInputFormatter(),
            ],
             controller: _counterTextController,
            keyboardType: TextInputType.number,
            onChanged: (changedText) {
              context.read<CreateInvoiceCubit>().changeReading(changedText);
            },
            maxLines: 1,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColor.c3000,
                  fontSize: 17.sf(context),
                ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _appLocalization.enter_last_indication.capitalize(),
                hintStyle: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: AppColor.c3000, fontSize: 17.sf(context))),
          )
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required AppLocalizations appLocalization,
  }) : _appLocalization = appLocalization, super(key: key);

  final AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColor.c60000,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            _appLocalization.cancel.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.black,fontSize: 14.sf(context)),
          ),
        )),
        AppDimension.horizontalSize_8,
        Expanded(
            child: BlocConsumer<CreateInvoiceCubit,
                CreateInvoiceState>(
          listener: (context, state) {
            if (state.stateStatus == StateStatus.failure) {
              MyApp.failureHandling(context, state.failure!);
            } else if (state.stateStatus == StateStatus.success) {

              Navigator.of(context).pop(true);
              showSuccessFlushBar(
                  context,
                  state.response?.statusMessage.translate(context
                          .read<LanguageCubit>()
                          .state
                          .languageCode) ??
                      '');
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onSurface: Colors.grey),
              onPressed: state.reading != null &&
                      state.reading!.isNotEmpty
                  ? () {
                      context
                          .read<CreateInvoiceCubit>()
                          .createInvoice(
                              apartmentId: context
                                  .read<AppCubit>()
                                  .getActiveApartment()
                                  .id);
                    }
                  : null,
              child: state.stateStatus == StateStatus.loading
                  ? const CupertinoActivityIndicator(radius: 12)
                  : Text(
                      _appLocalization.save.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white,fontSize: 14.sf(context)),
                    ),
            );
          },
        ))
      ],
    );
  }
}

class GoToHistoryScreenWidget extends StatelessWidget {
  const GoToHistoryScreenWidget({
    Key? key,
    required this.widget,
    required AppLocalizations appLocalization,
  }) : _appLocalization = appLocalization, super(key: key);

  final CounterBottomSheet widget;
  final AppLocalizations _appLocalization;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context, AppRouteName.indicationHistoryScreen,
            arguments: IndicationHistoryScreenParam(type:widget.type,counter: widget.counter));
      },
      child: Row(
        children: [
          Text(
            _appLocalization.history_indication.capitalize(),
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontSize: 17.sf(context), color: AppColor.c3000),
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.c6000),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}



