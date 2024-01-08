// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceService _$InvoiceServiceFromJson(Map<String, dynamic> json) =>
    InvoiceService(
      message: json['name'] == null
          ? null
          : Message.fromJson(json['name'] as Map<String, dynamic>),
      result: json['result'] as int?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$InvoiceServiceToJson(InvoiceService instance) =>
    <String, dynamic>{
      'name': instance.message,
      'result': instance.result,
      'type': instance.type,
    };
