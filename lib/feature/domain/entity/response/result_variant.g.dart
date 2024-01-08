// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_variant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultVariant _$ResultVariantFromJson(Map<String, dynamic> json) =>
    ResultVariant(
      id: json['id'] as String,
      count: json['count'] as int,
      percent: (json['percent'] as num).toDouble(),
    );

Map<String, dynamic> _$ResultVariantToJson(ResultVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count': instance.count,
      'percent': instance.percent,
    };
