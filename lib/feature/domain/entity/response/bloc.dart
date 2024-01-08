import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

part 'bloc.g.dart';

@JsonSerializable()
@HiveType(typeId: 8)
class Bloc extends Equatable {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'name')
  @HiveField(1)
  final Message name;

  const Bloc({required this.id, required this.name});

  factory Bloc.fromJson(Map<String, dynamic> json) {
    return _$BlocFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BlocToJson(this);

  @override
  List<Object?> get props => [id , name];
}
