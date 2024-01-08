import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:resident/app_package/core_package.dart';

part 'message.g.dart';

@JsonSerializable()
@HiveType(typeId: 12)
class Message extends Equatable {
  @HiveField(0)
  final String? uz;
  @HiveField(1)
  final String? oz;
  @HiveField(2)
  final String? ru;
  @HiveField(3)
  final String? en;

  const Message({
    this.uz,
    this.oz,
    this.ru,
    this.en,
  });

  Message copyWith({String? uz, String? oz, String? ru, String? en}) {
    return Message(
      uz: uz ?? this.uz,
      oz: oz ?? this.oz,
      ru: ru ?? this.ru,
      en: en ?? this.en,
    );
  }

  String? translate(String languageCode) {
    switch (languageCode) {
      case LanguageConst.english:
        return en;
      case LanguageConst.russian:
        return ru;
      case LanguageConst.uzbek:
        return uz;
      default:
        return oz;
    }
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return _$MessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  List<Object?> get props => [uz, oz, ru, en];
}
