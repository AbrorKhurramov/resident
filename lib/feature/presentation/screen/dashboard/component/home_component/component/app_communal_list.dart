import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:resident/feature/presentation/screen/dashboard/component/home_component/component/app_communal.dart';

import '../../../../../app_route/app_route_name.dart';

class AppCommunalList extends StatefulWidget {
  const AppCommunalList({Key? key}) : super(key: key);

  @override
  State<AppCommunalList> createState() => _AppCommunalListState();
}

class _AppCommunalListState extends State<AppCommunalList> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppCubit, AppState, String>(selector: (state) {
      return state.getActiveApartmentId();
    }, builder: (context, apartmentId) {
      context.read<CounterCubit>().getCounterList(apartmentId);
      return BlocConsumer<CounterCubit, CounterState>(
        listener: (context, counterState) {},
        builder: (context, counterState) {
          if (counterState.stateStatus == StateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (counterState.stateStatus == StateStatus.success) {
            return Column(
              children: [
                AppCommunal(type: 3, counter: counterState.responseColdWater!, apartmentId: apartmentId),
                AppDimension.verticalSize_12,
                AppCommunal(type: 2, counter: counterState.responseHotWater!, apartmentId: apartmentId),
                AppDimension.verticalSize_12,
                AppCommunal(type: 1, counter: counterState.responseElectric!, apartmentId: apartmentId),
                AppDimension.verticalSize_12,
                AppCommunal(type: 4, counter: counterState.responseGas!, apartmentId: apartmentId),
                AppDimension.verticalSize_12,
                AppCommunal(type: 5, counter: counterState.responseGas!, apartmentId: apartmentId,onTapAddOther: (){
                  Navigator.pushNamed(context, AppRouteName.otherCategoryScreen);
                },),
              ],
            );
          }
          return const SizedBox();
        },
      );
    });
  }
}
