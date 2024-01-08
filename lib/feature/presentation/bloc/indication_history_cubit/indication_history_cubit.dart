import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/feature/domain/entity/param/indication_history_param.dart';
import 'package:resident/feature/presentation/bloc/indication_history_cubit/indication_history_state.dart';

class IndicationHistoryCubit extends RepositoryCubit<IndicationHistoryState> {
  late final GetServiceResultUseCase getServiceResultUseCase;

  IndicationHistoryCubit({
    required this.getServiceResultUseCase,
    required int type,
  }) : super(IndicationHistoryState(
          stateStatus: StateStatus.initial,
          type: type,
          sortedIndication: const {},
        ));

  void getIndicationHistory(int page , String apartmentId,String? counterId, String dateFrom, String dateTo) async {
    emit(state.copyWith(stateStatus: StateStatus.loading,sortedIndication:const {}));
    print("rell");
    await getServiceResultUseCase
        .call(GetServiceResultUseCaseParams(
            type: state.type,
            apartmentId: apartmentId,
            filterRequestParam: IndicationHistoryParam(page: page,counterId: counterId, dateFrom: dateFrom, dateTo: dateTo),
            cancelToken: cancelToken))
        .fold(
      (left) {
        emit(state.copyWith(
            stateStatus: StateStatus.failure, loadingFailure: left));
      },
      (right) => emit(state.copyWith(
          stateStatus: StateStatus.success,
          response: right.copyWith(data: right.data),
          sortedIndication: _sortAppealHistory(right.data))),
    );
  }

  Future<void> getPaginationIndicationHistory(int page , String apartmentId,String counterNumber, String dateFrom, String dateTo) async {
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));
         print("ref");
    await getServiceResultUseCase
        .call(GetServiceResultUseCaseParams(
          type: state.type,
          apartmentId: apartmentId,
          filterRequestParam: IndicationHistoryParam(page: page,dateFrom: dateFrom,dateTo: dateTo),
          cancelToken: cancelToken,
        ))
        .fold(
          (left) => emit(state.copyWith(
              stateStatus: StateStatus.paginationFailure,
              paginationLoadingFailure: left)),
          (right) => emit(state.copyWith(
              stateStatus: StateStatus.success,
              response: right.copyWith(
                  totalPages: right.totalPages,
                  currentPage: right.currentPage,
                  totalItems: right.totalItems,
                  statusMessage: right.statusMessage,
                  statusCode: right.statusCode,
                  data: [...state.response!.data, ...right.data]),
              sortedIndication: _sortAppealHistory(right.data))),
        );
  }

  Map<String, List<ServiceResult>> _sortAppealHistory(
      List<ServiceResult> newData) {
    Map<String, List<ServiceResult>> newMap = {...state.sortedIndication};
    for (ServiceResult appealResponse in newData) {
      String createdDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('yyyy-MM-dd').parse(appealResponse.createdDate!));

      if (newMap[createdDate] == null) {
        newMap[createdDate] = [appealResponse];
      } else {
        newMap[createdDate] = [...newMap[createdDate]!, appealResponse];
      }
    }
    return newMap;
  }
}
