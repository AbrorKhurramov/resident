import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'base_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> extends Equatable {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'status_message')
  final Message statusMessage;
  @JsonKey(name: 'data')
  final List<T> data;

  const BaseListResponse(
      {required this.statusCode,
      required this.statusMessage,
      required this.data});

  factory BaseListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$BaseListResponseFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseListResponseToJson(this, toJsonT);

  BaseListResponse<T> copyWith(
      {int? statusCode,
      Message? statusMessage,
      List<T>? data,
      int? totalItems,
      int? totalPages,
      int? currentPage}) {
    return BaseListResponse<T>(
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        data: data ?? this.data);
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, data];
}
