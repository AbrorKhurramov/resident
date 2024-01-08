import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_variant.g.dart';

@JsonSerializable()
class ResultVariant extends Equatable {
  final String id;
  final int count;
  final double percent;

  const ResultVariant({
    required this.id,
    required this.count,
    required this.percent,
  });


  factory ResultVariant.fromJson(Map<String, dynamic> json) {
    return _$ResultVariantFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ResultVariantToJson(this);


  ResultVariant copyWith({String? id, int? count, double? percent}) {
    return ResultVariant(
        id: id ?? this.id,
        count: count ?? this.count,
        percent: percent ?? this.percent);
  }

  @override
  List<Object?> get props => [
        id,
        count,
        percent,
      ];
}
