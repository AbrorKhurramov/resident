import 'package:intl/intl.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:either_dart/either.dart';
import 'package:resident/feature/presentation/bloc/document_list_cubit/document_list_state.dart';

class DocumentListCubit extends RepositoryCubit<DocumentListState> {
  late final GetDocumentsUseCase _getDocumentsUseCase;

  DocumentListCubit(GetDocumentsUseCase appealTypesUseCase)
      : super(DocumentListState(
          stateStatus: StateStatus.initial,
          sortedDocument: const {},
        )) {
    _getDocumentsUseCase = appealTypesUseCase;
  }

  void getDocuments(String apartmentId,String dateFrom, String dateTo) async {
    emit(state.copyWith(stateStatus: StateStatus.loading,sortedDocument: const {}));
    await _getDocumentsUseCase
        .call(GetDocumentsUseCaseParams(
            apartmentId, FilterRequestParam(page: 0,dateFrom: dateFrom,dateTo: dateTo), cancelToken))
        .fold(
      (left) {
        emit(state.copyWith(
            stateStatus: StateStatus.failure, loadingFailure: left));
      },
      (right) => emit(state.copyWith(
          stateStatus: StateStatus.success,
          response: right.copyWith(data: right.data),
          sortedDocument: _sortDocumentHistory(right.data))),
    );
  }

  void getPaginationDocuments(String apartmentId, int page) async {
    emit(state.copyWith(stateStatus: StateStatus.paginationLoading));

    await _getDocumentsUseCase
        .call(GetDocumentsUseCaseParams(
            apartmentId, FilterRequestParam(page: page), cancelToken))
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
              sortedDocument: _sortDocumentHistory(right.data))),
        );
  }

  Map<String, List<Document>> _sortDocumentHistory(List<Document> newData) {
    Map<String, List<Document>> newMap = {...state.sortedDocument};
    for (Document appealResponse in newData) {
      String createdDate = DateFormat('yyyy-MM-dd')
          .format(DateFormat('yyyy-MM-dd').parse(appealResponse.createdDate.toString()));

      if (newMap[createdDate] == null) {
        newMap[createdDate] = [appealResponse];
      } else {
        newMap[createdDate] = [...newMap[createdDate]!, appealResponse];
      }
    }
    return newMap;
  }
}
