// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_pagination_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePaginationListResponse<T> _$BasePaginationListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BasePaginationListResponse<T>(
      statusCode: json['status_code'] as int,
      statusMessage:
          Message.fromJson(json['status_message'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
      totalItems: json['total_items'] as int,
      totalPages: json['total_pages'] as int,
      currentPage: json['current_page'] as int,
    );

Map<String, dynamic> _$BasePaginationListResponseToJson<T>(
  BasePaginationListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
      'data': instance.data.map(toJsonT).toList(),
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
    };
