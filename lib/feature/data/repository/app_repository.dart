import 'package:resident/app_package/data/data_repository_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';
import 'package:resident/feature/data/repository/app_repository_mixin.dart';
import 'package:resident/feature/data/repository/mixin/support_repository_mixin.dart';

import '../../domain/repository/notification_repository/notifications_count_repository.dart';
import 'mixin/notifications_count_repository_mixin.dart';



class AppRepositoryImpl
    with
        AuthRepositoryMixin,
        CardRepositoryMixin,
        CounterRepositoryMixin,
        LanguageRepositoryMixin,
        UserRepositoryMixin,
        PinCodeRepositoryMixin,
        PermissionRepositoryMixin,
        NotificationRepositoryMixin,
        TokenRepositoryMixin,
    SupportRepositoryMixin,
        NewsRepositoryMixin,
        AppealRepositoryMixin,
        NotificationsCountRepositoryMixin,
        PaymentRepositoryMixin,
        ImageRepositoryMixin,
        InvoiceRepositoryMixin,
        SurveyRepositoryMixin,
        AppRepositoryMixin,
        DocumentRepositoryMixin
    implements
        AuthRepository,
        CardRepository,
        CounterRepository,
        SupportRepository,
        LanguageRepository,
        PinCodeRepository,
        ByBiometricsPermissionRepository,
        NotificationRepository,
        NotificationsCountRepository,
        NewsRepository,
        AppealRepository,
        PaymentRepository,
        ImageRepository,
        InvoiceRepository,
        SurveyRepository,
        DocumentRepository {
  AppRepositoryImpl(
      {required AppRemoteSource appRemoteSource,
      required AppDatabaseSource appDatabaseSource,
      required AppPreferenceSource appSharedPreferenceSource}) {
    this.appRemoteSource = appRemoteSource;
    this.appDatabaseSource = appDatabaseSource;
    this.appSharedPreferenceSource = appSharedPreferenceSource;
  }
}
