// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      username: fields[1] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      phone: fields[4] as String,
      gender: fields[5] as bool?,
      email: fields[6] as String?,
      companies: (fields[7] as List).cast<Company>(),
      roles: (fields[8] as List).cast<Role>(),
      apartments: (fields[9] as List).cast<Apartment>(),
      logo: fields[10] as ImageFile?,
      firstEnter: fields[12] as bool?,
      registrationDate: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.companies)
      ..writeByte(8)
      ..write(obj.roles)
      ..writeByte(9)
      ..write(obj.apartments)
      ..writeByte(10)
      ..write(obj.logo)
      ..writeByte(11)
      ..write(obj.registrationDate)
      ..writeByte(12)
      ..write(obj.firstEnter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as bool?,
      email: json['email'] as String?,
      companies: (json['companies'] as List<dynamic>)
          .map((e) => Company.fromJson(e as Map<String, dynamic>))
          .toList(),
      roles: (json['roles'] as List<dynamic>)
          .map((e) => Role.fromJson(e as Map<String, dynamic>))
          .toList(),
      apartments: (json['apartments'] as List<dynamic>)
          .map((e) => Apartment.fromJson(e as Map<String, dynamic>))
          .toList(),
      logo: json['logo'] == null
          ? null
          : ImageFile.fromJson(json['logo'] as Map<String, dynamic>),
      firstEnter: json['first_enter'] as bool?,
      registrationDate: json['registration_date'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'gender': instance.gender,
      'email': instance.email,
      'companies': instance.companies,
      'roles': instance.roles,
      'apartments': instance.apartments,
      'logo': instance.logo,
      'registration_date': instance.registrationDate,
      'first_enter': instance.firstEnter,
    };
