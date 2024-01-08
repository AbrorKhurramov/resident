import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Company extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;

  Company({required this.id, required this.name});

  factory Company.fromJson(Map<String, dynamic> json) {
    return _$CompanyFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  List<Object?> get props => [id ,name];
}
