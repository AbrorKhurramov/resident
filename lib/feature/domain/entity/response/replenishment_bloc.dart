import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/message.dart';

import 'complex.dart';

part 'replenishment_bloc.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class ReplenishmentBloc extends Equatable{
  @HiveField(0)
  final String id;
  @JsonKey(name: 'name')
  @HiveField(1)
  final Message name;
  @HiveField(2)
  final Complex? complex;


  const ReplenishmentBloc({required this.id, required this.name,this.complex});

  factory ReplenishmentBloc.fromJson(Map<String, dynamic> json) {
    return _$ReplenishmentBlocFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReplenishmentBlocToJson(this);

  @override
  List<Object?> get props => [id, name,complex];


}
