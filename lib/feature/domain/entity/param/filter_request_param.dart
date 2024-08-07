import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'filter_request_param.g.dart';

@JsonSerializable()
class FilterRequestParam extends Equatable {
  @JsonKey(name: 'page')
  final int page;
  @JsonKey(name: 'size')
  late final int size;
  @JsonKey(name: 'date_from')
  final String? dateFrom;
  @JsonKey(name: 'date_to')
  final String? dateTo;
  @JsonKey(name: 'sort_by')
  final String? sortBy;
  @JsonKey(name: 'sort_dir')
  final String? sortDir;

  FilterRequestParam({
    required this.page,
    int? size,
    this.dateFrom,
    this.dateTo,
    this.sortBy,
    this.sortDir
  }) {
    this.size = size ?? 10;
  }

  factory FilterRequestParam.fromJson(Map<String, dynamic> json) {
    return _$FilterRequestParamFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FilterRequestParamToJson(this);

  Map<String, dynamic> queryParameters() {
    Map<String, dynamic> queryParameters = {
      'page': page,
      'size': size,
      'sort_by': sortBy??'createdDate',
      'sort_dir': sortDir??'desc'
    };

    if (dateFrom != null) {
      queryParameters['date_from'] = dateFrom;
    }
    if (dateTo != null) {
      queryParameters['date_to'] = dateTo;
    }

    return queryParameters;
  }

  @override
  List<Object?> get props => [
        page,
        size,
        dateFrom,
        dateTo,
      ];
}
