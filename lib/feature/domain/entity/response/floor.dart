import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'floor.g.dart';

@JsonSerializable()
@HiveType(typeId: 5)
class Floor extends Equatable {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'name')
  @HiveField(1)
  final Message name;

  const Floor({required this.id, required this.name});

  factory Floor.fromJson(Map<String, dynamic> json) {
    return _$FloorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FloorToJson(this);

  @override
  List<Object?> get props => [id, name];
}
