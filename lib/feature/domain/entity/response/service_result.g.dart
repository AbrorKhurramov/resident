// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResult _$ServiceResultFromJson(Map<String, dynamic> json) =>
    ServiceResult(
      result: json['result'] as int?,
      counterName: json['counterName'] as String?,
      counterNumber: json['counterNumber'] as String?,
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$ServiceResultToJson(ServiceResult instance) =>
    <String, dynamic>{
      'result': instance.result,
      'counterNumber': instance.counterNumber,
      'counterName': instance.counterName,
      'createdDate': instance.createdDate,
    };
