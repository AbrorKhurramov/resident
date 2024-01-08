import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:resident/app_package/core_package.dart';

enum AppealStatus { newStatus, inProgressStatus, confirmedStatus, notConfirmedStatus,completed }

extension AppealStatusExtension on AppealStatus {
  String getLabel(AppLocalizations appLocalization) {
    switch (this) {
      case AppealStatus.newStatus:
        return appLocalization.new_status.capitalize();
      case AppealStatus.inProgressStatus:
        return appLocalization.under_consideration.capitalize();
      case AppealStatus.confirmedStatus:
        return appLocalization.accepted.capitalize();
      case AppealStatus.notConfirmedStatus:
        return appLocalization.not_accepted.capitalize();
        case AppealStatus.completed:
        return appLocalization.completed.capitalize();
    }
  }
}
