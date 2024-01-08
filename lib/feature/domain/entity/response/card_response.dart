import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_response.g.dart';

@JsonSerializable()
class CardResponse extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'cardNumber')
  final String? cardNumber;
  @JsonKey(name: 'exDate')
  final String? expiryDate;
  @JsonKey(name: 'cardHolder')
  final String? cardHolder;
  @JsonKey(name: 'cardPhone')
  final String? cardPhone;
  @JsonKey(name: 'balance')
  final int? balance;

  const CardResponse(
      {this.id,
      this.cardNumber,
      this.expiryDate,
      this.cardHolder,
      this.cardPhone,
      this.balance});

  factory CardResponse.fromJson(Map<String, dynamic> json) {
    return _$CardResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CardResponseToJson(this);


  @override
  List<Object?> get props => [
        id,
        cardNumber,
        expiryDate,
        cardHolder,
        cardPhone,
        balance,
      ];
}
