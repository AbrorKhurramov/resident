// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 12;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      uz: fields[0] as String?,
      oz: fields[1] as String?,
      ru: fields[2] as String?,
      en: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uz)
      ..writeByte(1)
      ..write(obj.oz)
      ..writeByte(2)
      ..write(obj.ru)
      ..writeByte(3)
      ..write(obj.en);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      uz: json['uz'] as String?,
      oz: json['oz'] as String?,
      ru: json['ru'] as String?,
      en: json['en'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'uz': instance.uz,
      'oz': instance.oz,
      'ru': instance.ru,
      'en': instance.en,
    };
