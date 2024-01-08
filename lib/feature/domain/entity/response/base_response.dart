import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> extends Equatable {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'status_message')
  final Message statusMessage;
  @JsonKey(name: 'data')
  final T? data;

  const BaseResponse(
      {required this.statusCode,
      required this.statusMessage,
      required this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$BaseResponseFromJson(json, fromJsonT);
  }

  BaseResponse<T> copyWith({int? statusCode, Message? statusMessage, T? data}) {
    return BaseResponse<T>(
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        data: data ?? this.data);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [statusCode, statusMessage, data];
}
