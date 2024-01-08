// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sms_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmsCardResponse _$SmsCardResponseFromJson(Map<String, dynamic> json) =>
    SmsCardResponse(
      phoneNumber: json['phone_number'] as String?,
      confirmId: json['confirmId'] as int?,
      cardNumber: json['cardNumber'] as String?,
      expiryDate: json['exDate'] as String?,
    );

Map<String, dynamic> _$SmsCardResponseToJson(SmsCardResponse instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'confirmId': instance.confirmId,
      'cardNumber': instance.cardNumber,
      'exDate': instance.expiryDate,
    };
