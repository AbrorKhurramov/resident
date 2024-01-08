// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complex.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComplexAdapter extends TypeAdapter<Complex> {
  @override
  final int typeId = 9;

  @override
  Complex read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Complex(
      id: fields[0] as String,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Complex obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complex _$ComplexFromJson(Map<String, dynamic> json) => Complex(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ComplexToJson(Complex instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
