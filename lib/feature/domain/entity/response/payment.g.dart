// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      confirmType: json['confirmType'] as int?,
      createdDate: json['createdDate'] as String?,
      cardNumber: json['cardNumber'] as String?,
      transactionId: json['upayTransactionId'] as String?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'createdDate': instance.createdDate,
      'cardNumber': instance.cardNumber,
      'confirmType': instance.confirmType,
      'upayTransactionId': instance.transactionId,
    };
