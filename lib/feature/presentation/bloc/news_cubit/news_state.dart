import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class NewsState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<Newness>? response;
  final Failure? loadingFailure;
  final Failure? paginationFailure;

  const NewsState({required this.stateStatus, this.response, this.loadingFailure, this.paginationFailure});

  NewsState copyWith(
      {StateStatus? stateStatus,
      BasePaginationListResponse<Newness>? response,
      Failure? loadingFailure,
      Failure? paginationFailure}) {
    return NewsState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        loadingFailure: loadingFailure ?? this.loadingFailure,
        paginationFailure: paginationFailure ?? this.paginationFailure);
  }

  @override
  List<Object?> get props => [stateStatus, response, loadingFailure, paginationFailure];
}
