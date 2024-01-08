import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/component/app_modal_bottom_sheet.dart';
import 'package:resident/feature/presentation/component/empty_meter_reading.dart';
import 'package:resident/feature/presentation/component/meter_reading.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/home_component/component/counter_bottom_sheet.dart';

class AppCommunal extends StatefulWidget {
  final int type;
  final BasePaginationListResponse<Counter> counter;
  final String apartmentId;
  final void Function()? onTapAddOther;


  const AppCommunal({
    Key? key,
    required this.type,
    required this.counter,
    required this.apartmentId,
    this.onTapAddOther
  }) : super(key: key);

  @override
  State<AppCommunal> createState() => _AppCommunalState();
}

class _AppCommunalState extends State<AppCommunal> {
  void _onPressedCounterBottomSheet(List<Counter> counter) {
    showAppModalBottomSheet(
        context: context,
        builder: (_) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (_) => CreateInvoiceCubit(
                      createInvoiceUseCase: getIt<CreateInvoiceUseCase>(),
                      chosenCounter: counter[0])),
              BlocProvider(
                  create: (_) => ServiceResultCubit(
                      getServiceResultUseCase:
                          getIt<GetServiceResultUseCase>())),
            ],
            child: CounterBottomSheet(type: widget.type, counter: counter),
          );
        }).then((value) {
          if (value != null && value == true) {
        context.read<CounterCubit>().getCounterList(widget.apartmentId);
        context.read<ProfileCubit>().getProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onPressedCounterBottomSheet(widget.counter.data);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocConsumer<CounterCubit, CounterState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.stateStatus == StateStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.stateStatus == StateStatus.success &&
                  widget.counter.data.isNotEmpty) {
                bool isEmptyMeter = false;

                for (Counter counter in widget.counter.data) {
                  if (counter.serviceResult == null) {
                    isEmptyMeter = true;
                    break;
                  }
                }
                return isEmptyMeter
                    ? EmptyMeterReading(
                        communalType: widget.type.getCommunalType())
                    : MeterReading(
                        communalType: widget.type.getCommunalType(),
                        counters: widget.counter.data,onTapAddOther: widget.onTapAddOther);
              }
              return Container();
            }),
      ),
    );
  }
}
