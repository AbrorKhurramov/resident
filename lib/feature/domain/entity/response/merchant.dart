import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';

part 'merchant.g.dart';

@JsonSerializable()
class MerchantResponse extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'status')
  final bool? status;
  @JsonKey(name: 'name')
  final Message name;
  @JsonKey(name: 'description')
  final Message description;
  @JsonKey(name: 'file')
  final ImageFile imageFile;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'createdDate')
  final String? createdDate;

  const MerchantResponse({
    required this.id,
    required this.status,
    required this.imageFile,
    required this.name,
    required this.description,
    required this.type,
    required this.createdDate,
  });

  factory MerchantResponse.fromJson(Map<String, dynamic> json) {
    return _$MerchantResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MerchantResponseToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    imageFile,
    status,
    type,
    description,
    createdDate,
  ];
}
