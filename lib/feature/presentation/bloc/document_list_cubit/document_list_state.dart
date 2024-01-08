import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class DocumentListState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<Document>? response;
  final Map<String, List<Document>> sortedDocument;
  final Failure? loadingFailure;
  final Failure? paginationLoadingFailure;

  const DocumentListState({
    required this.stateStatus,
    this.response,
    required this.sortedDocument,
    this.loadingFailure,
    this.paginationLoadingFailure,
  });

  DocumentListState copyWith({
    StateStatus? stateStatus,
    BasePaginationListResponse<Document>? response,
    Map<String, List<Document>>? sortedDocument,
    Failure? loadingFailure,
    Failure? paginationLoadingFailure,
  }) {
    return DocumentListState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        sortedDocument: sortedDocument ?? this.sortedDocument,
        loadingFailure: loadingFailure,
        paginationLoadingFailure: paginationLoadingFailure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        sortedDocument,
        loadingFailure,
        paginationLoadingFailure,
      ];
}
