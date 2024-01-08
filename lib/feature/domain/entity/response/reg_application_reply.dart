

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/feature/domain/entity/response/image_file.dart';

part 'reg_application_reply.g.dart';



@JsonSerializable()
class RegApplicationReply extends Equatable {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'contentFiles')
  final List<ImageFile>? contentFiles;
  @JsonKey(name: "created_date")
  final String createdDate;



const  RegApplicationReply({required this.id,required this.content,required this.contentFiles,required this.createdDate});

factory RegApplicationReply.fromJson(Map<String, dynamic> json){
  return _$RegApplicationReplyFromJson(json);
}

  Map<String, dynamic> toJson() => _$RegApplicationReplyToJson(this);




  @override
  List<Object?> get props => [id,content,contentFiles,createdDate];

}