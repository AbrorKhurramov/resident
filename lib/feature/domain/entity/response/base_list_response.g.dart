// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListResponse<T> _$BaseListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseListResponse<T>(
      statusCode: json['status_code'] as int,
      statusMessage:
          Message.fromJson(json['status_message'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$BaseListResponseToJson<T>(
  BaseListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
      'data': instance.data.map(toJsonT).toList(),
    };
