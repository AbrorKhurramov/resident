import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'base_pagination_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BasePaginationListResponse<T> extends Equatable {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'status_message')
  final Message statusMessage;
  @JsonKey(name: 'data')
  final List<T> data;
  @JsonKey(name: 'total_items')
  final int totalItems;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'current_page')
  final int currentPage;

  const BasePaginationListResponse(
      {required this.statusCode,
      required this.statusMessage,
      required this.data,
      required this.totalItems,
      required this.totalPages,
      required this.currentPage});

  bool isLastPage() {
    return totalPages == currentPage + 1;
  }

  factory BasePaginationListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$BasePaginationListResponseFromJson(json, fromJsonT);
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$BasePaginationListResponseToJson(this, toJsonT);

  BasePaginationListResponse<T> copyWith(
      {int? statusCode, Message? statusMessage, List<T>? data, int? totalItems, int? totalPages, int? currentPage}) {
    return BasePaginationListResponse<T>(
        statusCode: statusCode ?? this.statusCode,
        statusMessage: statusMessage ?? this.statusMessage,
        data: data ?? this.data,
        totalItems: totalItems ?? this.totalItems,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  List<Object?> get props => [statusCode, statusMessage, data, totalItems, totalPages, currentPage];
}
