import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class CardState extends Equatable {
  final StateStatus stateStatus;
  final BasePaginationListResponse<CardResponse>? response;
  final Failure? failure;

  const CardState({
    required this.stateStatus,
    this.response,
    this.failure,
  });

  CardState copyWith(
      {StateStatus? stateStatus,
      BasePaginationListResponse<CardResponse>? response,
      Failure? failure}) {
    return CardState(
        stateStatus: stateStatus ?? this.stateStatus,
        response: response ?? this.response,
        failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        failure,
      ];
}
