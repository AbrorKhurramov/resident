import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'service.g.dart';

@JsonSerializable()
class Service extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final Message? message;

  const Service({this.id, this.message});

  factory Service.fromJson(Map<String, dynamic> json) {
    return _$ServiceFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

  @override
  List<Object?> get props => [
        id,
        message,
      ];
}
