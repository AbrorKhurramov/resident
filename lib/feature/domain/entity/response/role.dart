import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class Role extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;

  const Role({required this.id, required this.name, required this.description});

  factory Role.fromJson(Map<String, dynamic> json) {
    return _$RoleFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RoleToJson(this);

  @override
  List<Object?> get props => [id, name, description];
}
