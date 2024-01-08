import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment.g.dart';

@JsonSerializable()
class Payment extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  // @JsonKey(name: 'apartmentFullDto')
  // final Apartment apartment;
  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(name: 'createdDate')
  final String? createdDate;
  @JsonKey(name: 'cardNumber')
  final String? cardNumber;
  @JsonKey(name: 'confirmType')
  final int? confirmType;
  @JsonKey(name: 'upayTransactionId')
  final String? transactionId;

  const Payment({
    required this.id,
    // required this.apartment,
    this.amount,
    this.confirmType,
    required this.createdDate,
    this.cardNumber,
    this.transactionId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return _$PaymentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override
  List<Object?> get props => [
        id,
    confirmType,
        // apartment,
        amount,
        createdDate,
        cardNumber,
        transactionId,
      ];
}
