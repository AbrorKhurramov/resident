// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeal_history_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppealHistoryParam _$AppealHistoryParamFromJson(Map<String, dynamic> json) =>
    AppealHistoryParam(
      status: json['status'] as int?,
      type: json['type'] as int?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      size: json['size'] as int?,
      page: json['page'] as int,
    );

Map<String, dynamic> _$AppealHistoryParamToJson(AppealHistoryParam instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'status': instance.status,
      'type': instance.type,
    };
