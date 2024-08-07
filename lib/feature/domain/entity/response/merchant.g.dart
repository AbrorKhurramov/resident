// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MerchantResponse _$MerchantResponseFromJson(Map<String, dynamic> json) =>
    MerchantResponse(
      id: json['id'] as String?,
      status: json['status'] as bool?,
      imageFile: ImageFile.fromJson(json['file'] as Map<String, dynamic>),
      name: Message.fromJson(json['name'] as Map<String, dynamic>),
      description:
          Message.fromJson(json['description'] as Map<String, dynamic>),
      type: json['type'] as String,
      createdDate: json['createdDate'] as String?,
    );

Map<String, dynamic> _$MerchantResponseToJson(MerchantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'name': instance.name,
      'description': instance.description,
      'file': instance.imageFile,
      'type': instance.type,
      'createdDate': instance.createdDate,
    };
