import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'entrance.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class Entrance extends Equatable {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'name')
  @HiveField(1)
  final Message name;

  const Entrance({required this.id, required this.name});

  factory Entrance.fromJson(Map<String, dynamic> json) {
    return _$EntranceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EntranceToJson(this);

  @override
  List<Object?> get props => [id , name];
}
