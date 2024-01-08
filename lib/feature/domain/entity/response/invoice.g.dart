// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => Invoice(
      id: json['id'] as String?,
      amount: json['amount'] as int?,
      note: json['note'] as String?,
      closedDate: json['closedDate'] as String?,
      type: json['type'] as String?,
      invoice: json['invoice'] as String?,
      invoiceStatus: json['invoiceStatus'] as String?,
      createdDate: json['createdDate'] as String?,
      invoiceService: (json['serviceMinList'] as List<dynamic>)
          .map((e) => InvoiceService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'note': instance.note,
      'closedDate': instance.closedDate,
      'type': instance.type,
      'invoice': instance.invoice,
      'invoiceStatus': instance.invoiceStatus,
      'createdDate': instance.createdDate,
      'serviceMinList': instance.invoiceService,
    };
