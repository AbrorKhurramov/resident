import 'package:resident/app_package/data/data_repository_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/domain_repository_package.dart';




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
        ServicesRepositoryMixin,
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
        ServiceRepository,
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
