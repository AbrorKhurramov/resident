import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Token extends Equatable {
  @JsonKey(name: 'access_token')
  @HiveField(0)
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  @HiveField(1)
  final String refreshToken;
  @JsonKey(name: 'expires_in')
  @HiveField(2)
  final int expiresIn;
  @HiveField(3)
  @JsonKey(name: "created_date")
  final String createdDate;

  const Token(
      {required this.accessToken,
      required this.refreshToken,
      required this.expiresIn,
      required this.createdDate});

  factory Token.fromJson(Map<String, dynamic> json) {
    return _$TokenFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  List<Object?> get props =>
      [accessToken, refreshToken, expiresIn, createdDate];
}
