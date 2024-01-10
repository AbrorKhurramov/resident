import 'package:flutter/material.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/feature/presentation/screen/appeal/appeal_screen.dart';
import 'package:resident/feature/presentation/screen/appeal_history/appeal_history_screen.dart';
import 'package:resident/feature/presentation/screen/change_password/change_password_screen.dart';
import 'package:resident/feature/presentation/screen/change_phone/change_phone_screen.dart';
import 'package:resident/feature/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:resident/feature/presentation/screen/document/document_screen.dart';
import 'package:resident/feature/presentation/screen/events/events_screen.dart';
import 'package:resident/feature/presentation/screen/force_update/force_update_screen.dart';
import 'package:resident/feature/presentation/screen/indication_history/indication_history_screen.dart';
import 'package:resident/feature/presentation/screen/invoice/invoice_screen.dart';
import 'package:resident/feature/presentation/screen/invoice_list/invoice_list_screen.dart';
import 'package:resident/feature/presentation/screen/login/login_screen.dart';
import 'package:resident/feature/presentation/screen/mobile_providers/mobile_providers_screen.dart';
import 'package:resident/feature/presentation/screen/my_card/my_card_screen.dart';
import 'package:resident/feature/presentation/screen/my_flat/my_flat_screen.dart';
import 'package:resident/feature/presentation/screen/other_category/other_category_screen.dart';
import 'package:resident/feature/presentation/screen/payment_history/payment_history_screen.dart';
import 'package:resident/feature/presentation/screen/pin_code/enum/pin_code_status.dart';
import 'package:resident/feature/presentation/screen/pin_code/pin_code_screen.dart';
import 'package:resident/feature/presentation/screen/replenish_balance/replenish_balance_screen.dart';
import 'package:resident/feature/presentation/screen/security/security_screen.dart';
import 'package:resident/feature/presentation/screen/settings/settings_screen.dart';
import 'package:resident/feature/presentation/screen/splash/splash_screen.dart';
import 'package:resident/feature/presentation/screen/story/story_screen.dart';
import 'package:resident/feature/presentation/screen/survey/survey_screen.dart';

import 'app_route_name.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.loginScreen:
        return LoginScreen.route();
      case AppRouteName.pinCodeScreen:
        return PinCodeScreen.route(settings.arguments as PinCodeStatus?);
      // case AppRouteName.notInternetScreen:
      //   return MaterialPageRoute(builder: (_) => const NotInternetScreen());
      case AppRouteName.splashScreen:
        return SplashScreen.route();
      case AppRouteName.dashboardScreen:
        return DashboardScreen.route();
        case AppRouteName.eventsScreen:
        return EventsScreen.route();
      case AppRouteName.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case AppRouteName.forceUpdate:
        return MaterialPageRoute(builder: (_) => const ForceUpdateScreen());
     case AppRouteName.changePhoneScreen:
        return MaterialPageRoute(builder: (_) => const ChangePhoneScreen());
      case AppRouteName.securitySettingsScreen:
        return MaterialPageRoute(builder: (_) => const SecurityScreen());
      case AppRouteName.myFlatScreen:
        return MyFlatScreen.route();
      case AppRouteName.myCardScreen:
        return MyCardScreen.route();
      case AppRouteName.paymentHistoryScreen:
        return PaymentHistoryScreen.route();
      case AppRouteName.appealScreen:
        return AppealScreen.route();
      case AppRouteName.appealHistoryScreen:
        return AppealHistoryScreen.route();
        case AppRouteName.changePasswordScreen:
        return ChangePasswordScreen.route(settings.arguments as String);
      case AppRouteName.storyScreen:
        return StoryScreen.route(settings.arguments as StoryScreenParams);
      case AppRouteName.invoiceScreen:
        return InvoiceListScreen.route(settings.arguments as String?);
      case AppRouteName.invoiceScreenItem:
        return InvoiceScreen.route(settings.arguments as Invoice);
      case AppRouteName.documentScreen:
        return DocumentScreen.route();
        case AppRouteName.otherCategoryScreen:
        return OtherCategoryScreen.route();
        case AppRouteName.mobileProvidersScreen:
        return MobileProvidersScreen.route();
      case AppRouteName.replenishBalanceScreen:
        return ReplenishBalanceScreen.route();
      case AppRouteName.indicationHistoryScreen:
        return IndicationHistoryScreen.route(settings.arguments as IndicationHistoryScreenParam);
      case AppRouteName.surveyScreen:
        return SurveyScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
          body: Center(
        child: Text('Error Route'),
      ));
    });
  }
}
