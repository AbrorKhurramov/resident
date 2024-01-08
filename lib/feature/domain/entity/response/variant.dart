import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'variant.g.dart';


@JsonSerializable()
class Variant extends Equatable {
  final String id;
  final Message name;
  final String note;
  final Message description;

  const Variant({
    required this.id,
    required this.name,
    required this.note,
    required this.description,
  });


  factory Variant.fromJson(Map<String, dynamic> json) {
    return _$VariantFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VariantToJson(this);



  Variant copyWith({
    String? id,
    Message? name,
    String? note,
    Message? description,
  }) {
    return Variant(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [id, name, note, description];
}
