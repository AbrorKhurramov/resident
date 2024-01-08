import 'package:resident/app_package/core_package.dart';

extension QuestionExtension on int {
  QuestionType getQuestionType() {
    switch (this) {
      case 1:
        return QuestionType.singleType;
      default:
        return QuestionType.multiType;
    }
  }
}
