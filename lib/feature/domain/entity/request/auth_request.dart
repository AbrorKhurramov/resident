import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  final String username;
  final String password;
  @JsonKey(name: "firebase_token")
  final String firebaseToken;


  AuthRequest({required this.username, required this.password,required this.firebaseToken});

  factory AuthRequest.fromJson(Map<String, dynamic> json) {
    return _$AuthRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);

}
