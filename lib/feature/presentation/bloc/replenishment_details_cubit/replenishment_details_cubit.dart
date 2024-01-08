import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/feature/presentation/bloc/replenishment_details_cubit/replenishment_details_state.dart';

import '../../../domain/use_case/payment_use_case/replenishment_details_use_case.dart';
import 'package:either_dart/either.dart';

class ReplenishmentDetailsCubit extends RepositoryCubit<ReplenishmentDetailsState> {

 final ReplenishmentDetailsUseCase replenishmentDetailsUseCase;

 ReplenishmentDetailsCubit({required this.replenishmentDetailsUseCase})
     : super(ReplenishmentDetailsState(stateStatus: StateStatus.initial));

 void getReplenishmentDetails( String apartmentId) {
  emit(state.copyWith(stateStatus: StateStatus.loading,));

  replenishmentDetailsUseCase
      .call(ReplenishmentDetailsUseCaseParams(
      apartmentId: apartmentId,
      cancelToken: cancelToken))
      .fold(
          (left) => emit(state.copyWith(
          stateStatus: StateStatus.failure, failure: left)),
          (right) => emit(state.copyWith(
          stateStatus: StateStatus.success, response: right)));
 }


}
