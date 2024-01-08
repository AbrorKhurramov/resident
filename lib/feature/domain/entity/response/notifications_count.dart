import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notifications_count.g.dart';


@JsonSerializable()
class NotificationsCount extends Equatable{
  @JsonKey(name: 'regApplicationReplyCount')
  final int? regApplicationReplyCount;
  @JsonKey(name: 'surveyCount')
  final int? surveyCount;
  @JsonKey(name: 'serviceCount')
  final int? serviceCount;
  @JsonKey(name: 'invoiceCount')
  final int? invoiceCount;

  const NotificationsCount({
    this.regApplicationReplyCount,
    this.surveyCount,
    this.serviceCount,
    this.invoiceCount
});

  NotificationsCount copyWith({int? regApplicationReplyCount,int? surveyCount,int? serviceCount,int? invoiceCount}) {
    return NotificationsCount(
      regApplicationReplyCount: regApplicationReplyCount??this.regApplicationReplyCount,
      surveyCount: surveyCount??this.surveyCount,
      serviceCount: serviceCount??this.serviceCount,
      invoiceCount: invoiceCount??this.invoiceCount
    );

  }
  factory NotificationsCount.fromJson(Map<String, dynamic> json) {
    return _$NotificationsCountFromJson(json);
  }
  Map<String, dynamic> toJson() => _$NotificationsCountToJson(this);

  @override
  List<Object?> get props => [regApplicationReplyCount,surveyCount,serviceCount,invoiceCount];



}