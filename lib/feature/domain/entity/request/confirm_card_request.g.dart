// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmCardRequest _$ConfirmCardRequestFromJson(Map<String, dynamic> json) =>
    ConfirmCardRequest(
      cardNumber: json['card_number'] as String?,
      expiryDate: json['card_expire_date'] as String?,
      confirmId: json['confirm_id'] as int?,
      phoneNumber: json['card_phone'] as String?,
      confirmSms: json['confirm_sms'] as String?,
      lang: json['lang'] as String?,
    );

Map<String, dynamic> _$ConfirmCardRequestToJson(ConfirmCardRequest instance) =>
    <String, dynamic>{
      'card_number': instance.cardNumber,
      'card_expire_date': instance.expiryDate,
      'confirm_id': instance.confirmId,
      'card_phone': instance.phoneNumber,
      'confirm_sms': instance.confirmSms,
      'lang': instance.lang,
    };
