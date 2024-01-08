// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indication_history_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndicationHistoryParam _$IndicationHistoryParamFromJson(
        Map<String, dynamic> json) =>
    IndicationHistoryParam(
      counterId: json['counter_id'] as String?,
      dateFrom: json['date_from'] as String?,
      dateTo: json['date_to'] as String?,
      size: json['size'] as int?,
      page: json['page'] as int,
    );

Map<String, dynamic> _$IndicationHistoryParamToJson(
        IndicationHistoryParam instance) =>
    <String, dynamic>{
      'page': instance.page,
      'size': instance.size,
      'date_from': instance.dateFrom,
      'date_to': instance.dateTo,
      'counter_id': instance.counterId,
    };
