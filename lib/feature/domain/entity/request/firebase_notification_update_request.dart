




import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firebase_notification_update_request.g.dart';

@JsonSerializable()
class FirebaseNotificationUpdateRequest extends Equatable{
  @JsonKey(name: 'notification')
  final bool? notification;
  @JsonKey(name: 'fire_base_token')
  final String? firebaseToken;

  const FirebaseNotificationUpdateRequest({this.notification, this.firebaseToken});



  factory FirebaseNotificationUpdateRequest.fromJson(Map<String, dynamic> json) => _$FirebaseNotificationUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseNotificationUpdateRequestToJson(this);


  FirebaseNotificationUpdateRequest copyWith({bool? notification,String? firebaseToken}) {
    return FirebaseNotificationUpdateRequest(
      firebaseToken: firebaseToken ?? this.firebaseToken,
      notification: notification ?? this.notification);
  }
    @override
  // TODO: implement props
  List<Object?> get props => [notification,firebaseToken];

}
