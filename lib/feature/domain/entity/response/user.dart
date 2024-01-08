import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/apartment.dart';
import 'package:resident/feature/domain/entity/response/company.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';
import 'package:resident/feature/domain/entity/response/role.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class User extends Equatable {
  @HiveField(0)
  final String id;
  @JsonKey(name: 'username')
  @HiveField(1)
  final String username;
  @JsonKey(name: 'first_name')
  @HiveField(2)
  final String firstName;
  @JsonKey(name: 'last_name')
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final bool? gender;
  @HiveField(6)
  final String? email;
  @HiveField(7)
  final List<Company> companies;
  @HiveField(8)
  final List<Role> roles;
  @HiveField(9)
  final List<Apartment> apartments;
  @HiveField(10)
  final ImageFile? logo;
  @HiveField(11)
  @JsonKey(name: 'registration_date')
  final String? registrationDate;
  @HiveField(12)
  @JsonKey(name: 'first_enter')
  final bool? firstEnter;

  const User(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.gender,
      required this.email,
      required this.companies,
      required this.roles,
      required this.apartments,
      this.logo,
      this.firstEnter,
      this.registrationDate});

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  Apartment getActiveApartment() {
    for (Apartment apartment in apartments) {
      if (apartment.selected!) return apartment;
    }
    return apartments[0];
  }

  User copyWith(
      {String? id,
      String? username,
      String? firstName,
      String? lastName,
      String? phone,
      bool? gender,
      bool? firstEnter,
      String? email,
      List<Company>? companies,
      List<Role>? roles,
      List<Apartment>? apartments,
      ImageFile? logo,
      String? registrationDate}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      firstEnter: firstEnter ?? this.firstEnter,
      email: email ?? this.email,
      companies: companies ?? this.companies,
      roles: roles ?? this.roles,
      apartments: apartments ?? this.apartments,
      logo: logo ?? this.logo,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        firstName,
        lastName,
        phone,
    firstEnter,
        gender,
        email,
        companies,
        roles,
        apartments,
        logo,
        registrationDate
      ];
}
