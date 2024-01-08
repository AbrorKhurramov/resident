import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_update_request.g.dart';

@JsonSerializable()
class UserUpdateRequest extends Equatable {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'photo_id')
  final String? photoId;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  const UserUpdateRequest({
    this.firstName,
    this.lastName,
    this.photoId,
    this.phoneNumber
  });

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) => _$UserUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);


  UserUpdateRequest copyWith({String? firstName, String? lastName, String? photoId, String? phoneNumber,bool? notification,String? firebaseToken}) {
    return UserUpdateRequest(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        photoId: photoId ?? this.photoId,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        photoId,
        phoneNumber,
     ];
}
