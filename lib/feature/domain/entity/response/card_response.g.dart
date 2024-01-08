// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResponse _$CardResponseFromJson(Map<String, dynamic> json) => CardResponse(
      id: json['id'] as String?,
      cardNumber: json['cardNumber'] as String?,
      expiryDate: json['exDate'] as String?,
      cardHolder: json['cardHolder'] as String?,
      cardPhone: json['cardPhone'] as String?,
      balance: json['balance'] as int?,
    );

Map<String, dynamic> _$CardResponseToJson(CardResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardNumber': instance.cardNumber,
      'exDate': instance.expiryDate,
      'cardHolder': instance.cardHolder,
      'cardPhone': instance.cardPhone,
      'balance': instance.balance,
    };
