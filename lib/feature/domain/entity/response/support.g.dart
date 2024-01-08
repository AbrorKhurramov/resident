// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Support _$SupportFromJson(Map<String, dynamic> json) => Support(
      type: json['type'] as int,
      contactPerson: json['contactPerson'] as String,
      contactData: json['contactData'] as String,
    );

Map<String, dynamic> _$SupportToJson(Support instance) => <String, dynamic>{
      'type': instance.type,
      'contactPerson': instance.contactPerson,
      'contactData': instance.contactData,
    };
