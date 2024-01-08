// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_request_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterRequestParam _$FilterRequestParamFromJson(Map<String, dynamic> json) =>
    FilterRequestParam(
      page: json['page'] as int,
      size: json['size'] as int?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
    );

Map<String, dynamic> _$FilterRequestParamToJson(FilterRequestParam instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
    };
