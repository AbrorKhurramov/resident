import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sms_card_response.g.dart';

@JsonSerializable()
class SmsCardResponse extends Equatable {
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  @JsonKey(name: 'confirmId')
  final int? confirmId;
  @JsonKey(name: 'cardNumber')
  final String? cardNumber;
  @JsonKey(name: 'exDate')
  final String? expiryDate;

  const SmsCardResponse({
    this.phoneNumber,
    this.confirmId,
    this.cardNumber,
    this.expiryDate,
  });

  factory SmsCardResponse.fromJson(Map<String, dynamic> json) => _$SmsCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SmsCardResponseToJson(this);

  @override
  List<Object?> get props => [
        phoneNumber,
        confirmId,
        cardNumber,
        expiryDate,
      ];
}
