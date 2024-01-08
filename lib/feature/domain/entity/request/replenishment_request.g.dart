// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replenishment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplenishmentRequest _$ReplenishmentRequestFromJson(
        Map<String, dynamic> json) =>
    ReplenishmentRequest(
      cardId: json['card_id'] as String,
      amount: json['amount'] as int,
      personalAccount: json['personal_account'] as String,
    );

Map<String, dynamic> _$ReplenishmentRequestToJson(
        ReplenishmentRequest instance) =>
    <String, dynamic>{
      'card_id': instance.cardId,
      'amount': instance.amount,
      'personal_account': instance.personalAccount,
    };
