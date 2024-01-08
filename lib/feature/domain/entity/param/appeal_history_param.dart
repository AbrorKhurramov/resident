






import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/domain/entity_package.dart';


part 'appeal_history_param.g.dart';



@JsonSerializable()
class AppealHistoryParam extends FilterRequestParam{
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'type')
  final int? type;


  AppealHistoryParam( {this.status,this.type,String? dateFrom,String? dateTo,int? size, required int page}) : super(page: page,dateFrom: dateFrom,size:size,dateTo: dateTo);


  factory AppealHistoryParam.fromJson(Map<String, dynamic> json) {
    return _$AppealHistoryParamFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AppealHistoryParamToJson(this);


  @override
  Map<String, dynamic> queryParameters() {
    Map<String, dynamic> queryParameters = super.queryParameters();
    if(status!=null) {
      queryParameters["status"]  = status;
    }
    if(type!=null){
      queryParameters["type"]  = type;
    }

    return queryParameters;
  }

  @override
  List<Object?> get props => [
    super.props,
    status,
    type
  ];


}