import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'replenishment_request.g.dart';

@JsonSerializable()
class ReplenishmentRequest extends Equatable {
  @JsonKey(name: 'card_id')
  final String cardId;
  @JsonKey(name: 'amount')
  final int amount;
  @JsonKey(name: 'personal_account')
  final String personalAccount;

  const ReplenishmentRequest({
    required this.cardId,
    required this.amount,
    required this.personalAccount,
  });

  factory ReplenishmentRequest.fromJson(Map<String, dynamic> json) {
    return _$ReplenishmentRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReplenishmentRequestToJson(this);

  @override
  List<Object?> get props => [cardId, amount, personalAccount];
}
