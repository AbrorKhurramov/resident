import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complex.g.dart';

@JsonSerializable()
@HiveType(typeId: 9)
class Complex extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  const Complex({required this.id, required this.name});

  factory Complex.fromJson(Map<String, dynamic> json) {
    return _$ComplexFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ComplexToJson(this);

  @override
  List<Object?> get props => [id, name];
}
