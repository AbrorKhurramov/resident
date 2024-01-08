import 'package:equatable/equatable.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

class AddCardState extends Equatable {
  final StateStatus stateStatus;
  final BaseResponse<SmsCardResponse>? response;
  final String cardNumber;
  final String expiryDate;
  final Failure? failure;

  const AddCardState({
    required this.stateStatus,
    this.response,
    required this.cardNumber,
    required this.expiryDate,
    this.failure,
  });

  AddCardState copyWith({
    StateStatus? stateStatus,
    BaseResponse<SmsCardResponse>? response,
    String? cardNumber,
    String? expiryDate,
    Failure? failure,
  }) {
    return AddCardState(
      stateStatus: stateStatus ?? this.stateStatus,
      response: response ?? this.response,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        stateStatus,
        response,
        cardNumber,
        expiryDate,
        failure,
      ];
}
