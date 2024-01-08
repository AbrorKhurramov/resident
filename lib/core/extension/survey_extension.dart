import 'package:resident/app_package/core_package.dart';

extension SurveyExtension on int {
  SurveyType getSurveyType() {
    switch (this) {
      case 1:
        return SurveyType.survey;
      default:
        return SurveyType.vote;

    }
  }
}
