


import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support.g.dart';

@JsonSerializable()
class Support extends Equatable{
  @JsonKey(name:'type')
  final int type;
  @JsonKey(name:'contactPerson')
  final String contactPerson;
  @JsonKey(name:'contactData')
  final String contactData;

  const Support({
    required this.type,
    required this.contactPerson,
    required this.contactData
});


  factory Support.fromJson(Map<String, dynamic> json) {
    return _$SupportFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SupportToJson(this);


  Support copyWith({
   int? type,
    String? contactPerson,
    String? contactData

  }) {
    return Support(
        type: type ?? this.type,
        contactPerson: contactPerson ?? this.contactPerson,
        contactData: contactData ?? this.contactData
    );
  }

  @override
  List<Object?> get props => [
   type,
    contactPerson,
    contactData
  ];


}