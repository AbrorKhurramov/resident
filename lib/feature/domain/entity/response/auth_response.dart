import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/token.dart';
import 'package:resident/feature/domain/entity/response/user.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: 'token_info')
  final Token token;

  @JsonKey(name: 'user_info')
  final User user;

  AuthResponse({required this.token, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
