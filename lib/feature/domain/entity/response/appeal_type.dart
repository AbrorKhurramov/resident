import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'appeal_type.g.dart';

@JsonSerializable()
class AppealType extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final Message name;

  const AppealType({required this.id, required this.name});

  factory AppealType.fromJson(Map<String, dynamic> json) {
    return _$AppealTypeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppealTypeToJson(this);

  @override
  List<Object?> get props => [id, name];
}
