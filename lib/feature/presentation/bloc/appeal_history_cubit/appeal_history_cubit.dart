import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/feature/domain/use_case/appeal_use_case/appeal_history_by_id_use_case.dart';

import '../../../domain/entity/param/appeal_history_param.dart';
import 'appeal_history_state.dart';

class AppealHistoryCubit extends RepositoryCubit<AppealHistoryState> {
  late final AppealHistoryUseCase _appealTypesUseCase;
  late final AppealHistoryByIDUseCase _appealHistoryByIDUseCase;

  AppealHistoryCubit(AppealHistoryUseCase appealTypesUseCase,AppealHistoryByIDUseCase appealHistoryByIDUseCase)
      : super(AppealHistoryState(
          stateStatus: StateStatus.initial,
          sortedAppeal: const {},
        )) {
    _appealTypesUseCase = appealTypesUseCase;
    _appealHistoryByIDUseCase = appealHistoryByIDUseCase;
  }

  void getAppealHistory(String apartmentId,int? status,int? type, String dateFrom, String dateTo) async {
    emit(state.copyWith(stateStatus: StateStatus.loading,sortedAppeal: const {}));
    await _appealTypesUseCase
        .call(AppealHistoryUseCaseParams(
            apartmentId, AppealHistoryParam(page: 0,status: status,type: type,dateFrom: dateFrom,dateTo: dateTo), cancelToken))
        .fold(
      (left) {
        emit(state.copyWith(
            stateStatus: StateStatus.failure, loadingFailure: left));
      },
      (right) {
        emit(state.copyWith(
          stateStatus: StateStatus.success,
          response: right.copyWith(data: right.data),
          sortedAppeal: _sortAppealHistory(right.data)));
      },
    );
  }

  void onTapAppeal(String id) async{
    await _appealHistoryByIDUseCase.call(AppealHistoryByIDUseCaseParams(id, cancelToken)).fold((left) {
      emit(state.copyWith(
          stateStatus: StateStatus.failure, loadingFailure: left));
    }, (right) {
      print("onTapAppeal");
      print(right.toString());
    });
  }


  void getPaginationAppealHistory(String apartmentId, int page) async {
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));

    await _appealTypesUseCase
        .call(AppealHistoryUseCaseParams(
            apartmentId, AppealHistoryParam(page: page), cancelToken))
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
              sortedAppeal: _sortAppealHistory(right.data))),
        );
  }

  Map<String, List<AppealResponse>> _sortAppealHistory(
      List<AppealResponse> newData) {
    Map<String, List<AppealResponse>> newMap = {...state.sortedAppeal};
    for (AppealResponse appealResponse in newData) {
      String createdDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('yyyy-MM-dd').parse(appealResponse.createdDate));

      if (newMap[createdDate] == null) {
        newMap[createdDate] = [appealResponse];
      } else {
        newMap[createdDate] = [...newMap[createdDate]!, appealResponse];
      }
    }
    return newMap;
  }
}
