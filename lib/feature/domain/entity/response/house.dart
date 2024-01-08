import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'house.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class House extends Equatable {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'name')
  @HiveField(1)
  final Message name;

  const House({required this.id, required this.name});

  factory House.fromJson(Map<String, dynamic> json) {
    return _$HouseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HouseToJson(this);

  @override
  List<Object?> get props => [id, name];
}
