import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_card_request.g.dart';

@JsonSerializable()
class ConfirmCardRequest extends Equatable {
  @JsonKey(name: 'card_number')
  final String? cardNumber;
  @JsonKey(name: 'card_expire_date')
  final String? expiryDate;
  @JsonKey(name: 'confirm_id')
  final int? confirmId;
  @JsonKey(name: 'card_phone')
  final String? phoneNumber;
  @JsonKey(name: 'confirm_sms')
  final String? confirmSms;
  @JsonKey(name: 'lang')
  final String? lang;

  const ConfirmCardRequest({
    this.cardNumber,
    this.expiryDate,
    this.confirmId,
    this.phoneNumber,
    this.confirmSms,
    this.lang,
  });

  factory ConfirmCardRequest.fromJson(Map<String, dynamic> json) {
    return _$ConfirmCardRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ConfirmCardRequestToJson(this);


  @override
  List<Object?> get props => [
        cardNumber,
        expiryDate,
        confirmId,
        phoneNumber,
        confirmSms,
        lang,
      ];
}
