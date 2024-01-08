// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Counter _$CounterFromJson(Map<String, dynamic> json) => Counter(
      id: json['id'] as String,
      service: json['serviceMin'] == null
          ? null
          : Service.fromJson(json['serviceMin'] as Map<String, dynamic>),
      servicePriceMin: json['servicePriceMin'] == null
          ? null
          : ServicePriceMin.fromJson(
              json['servicePriceMin'] as Map<String, dynamic>),
      type: json['type'] as String,
      counterNumber: json['counterNumber'] as String?,
      counterName: json['counterName'] as String?,
      serviceResult: json['serviceResult'] as int?,
      balance: json['balance'] as int,
      status: json['monthlyStatus'] as bool,
      invoiceStatus: json['invoiceStatus'] as bool,
    );

Map<String, dynamic> _$CounterToJson(Counter instance) => <String, dynamic>{
      'id': instance.id,
      'serviceMin': instance.service,
      'servicePriceMin': instance.servicePriceMin,
      'type': instance.type,
      'counterNumber': instance.counterNumber,
      'counterName': instance.counterName,
      'serviceResult': instance.serviceResult,
      'balance': instance.balance,
      'monthlyStatus': instance.status,
      'invoiceStatus': instance.invoiceStatus,
    };
