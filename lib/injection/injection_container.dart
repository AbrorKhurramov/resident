import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/data/data_repository_package.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/use_case_package.dart';
import 'package:resident/app_package/injection_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:resident/feature/domain/use_case/appeal_use_case/appeal_history_by_id_use_case.dart';
import 'package:resident/feature/domain/use_case/auth_use_case/force_update_use_case.dart';
import 'package:resident/feature/domain/use_case/notification_use_case/notifications_count_use_case.dart';
import 'package:resident/feature/domain/use_case/service_use_case/get_services_list_use_case.dart';
import 'package:resident/feature/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:resident/injection/params/notification_param.dart';
import 'package:resident/injection/params/permission_param.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_package/domain/entity_package.dart';
import '../feature/presentation/app_route/navigation_route.dart';

final getIt = GetIt.instance;

Future<void> init(String sysLang) async {
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TokenAdapter());
    Hive.registerAdapter(CompanyAdapter());
    Hive.registerAdapter((RoleAdapter()));
    Hive.registerAdapter(ApartmentAdapter());
    Hive.registerAdapter(FloorAdapter());
    Hive.registerAdapter(EntranceAdapter());
    Hive.registerAdapter(HouseAdapter());
    Hive.registerAdapter(BlocAdapter());
    Hive.registerAdapter(ComplexAdapter());
    Hive.registerAdapter(ImageFileAdapter());
    Hive.registerAdapter(MessageAdapter());

    LazyBox<User> userBox = await Hive.openLazyBox('user');
    LazyBox<Token> tokenBox = await Hive.openLazyBox('token');

    getIt.registerLazySingleton<LazyBox<User>>(() => userBox);
    getIt.registerLazySingleton<LazyBox<Token>>(() => tokenBox);

    //navigation
    getIt.registerLazySingleton<NavigationRoute>(
          () => NavigationRoute(),
    );


    // External library
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage());
    getIt.registerLazySingleton<Dio>(
        () => AppRemoteSourceImpl.initDio(getIt<UserParam>().token));
    // initialize Data source
    getIt.registerLazySingleton<AppRemoteSourceImpl>(() =>
        AppRemoteSourceImpl(getIt<Dio>(), getIt<AppDatabaseSourceImpl>()));
    getIt.registerLazySingleton<AppDatabaseSourceImpl>(
        () => AppDatabaseSourceImpl());
    getIt.registerLazySingleton<AppPreferenceSourceImpl>(() =>
        AppPreferenceSourceImpl(
            sharedPreferences: getIt<SharedPreferences>(),
            flutterSecureStorage: getIt<FlutterSecureStorage>()));

    // AppRepository
    getIt.registerLazySingleton(() => AppRepositoryImpl(
        appRemoteSource: getIt<AppRemoteSourceImpl>(),
        appDatabaseSource: getIt<AppDatabaseSourceImpl>(),
        appSharedPreferenceSource: getIt<AppPreferenceSourceImpl>()));

    getIt.registerLazySingleton<InternetConnectionChecker>(
        () => InternetConnectionChecker());

    User? user = await getIt<AppDatabaseSourceImpl>().getUser();
    Token? token = await getIt<AppDatabaseSourceImpl>().getToken();
    String? languageCode =
        await getIt<AppPreferenceSourceImpl>().getLanguageCode();
    String? pinCode = await getIt<AppPreferenceSourceImpl>().getPinCode();
    bool notification =
        await getIt<AppPreferenceSourceImpl>().getNotification();
    bool permission =
        await getIt<AppPreferenceSourceImpl>().getPermission();
    bool hasConnection = await getIt<InternetConnectionChecker>().hasConnection;

    getIt.registerFactory<UserParam>(() => UserParam(user: user, token: token));
    getIt.registerFactory<LanguageParam>(
        () => LanguageParam(languageCode: languageCode));
    getIt.registerFactory<PinCodeParam>(() => PinCodeParam(pinCode: pinCode));
    getIt.registerFactory<NotificationParam>(
        () => NotificationParam(notification: notification));
    getIt.registerFactory<PermissionParam>(
        () => PermissionParam(permission: permission));
    getIt.registerFactory<InternetParam>(
        () => InternetParam(hasConnection: hasConnection));

    // initialize bloc

    getIt.registerFactory<MyFlatCubit>(() => MyFlatCubit(
          changeApartmentUseCase: getIt<ChangeApartmentUseCase>(),
        ));
    getIt.registerFactory<PaymentHistoryCubit>(() => PaymentHistoryCubit(
          getIt<PaymentHistoryUseCase>(),
        ));
    getIt.registerFactory<ReplenishmentDetailsCubit>(() => ReplenishmentDetailsCubit(replenishmentDetailsUseCase: getIt<ReplenishmentDetailsUseCase>()));
    getIt.registerFactory<NotInternetCubit>(
        () => NotInternetCubit(getIt<InternetParam>().hasConnection));
    getIt.registerFactory<AppCubit>(() => AppCubit(
        insertUserUseCase: getIt<InsertUserUseCase>(),
        deleteUserUseCase: getIt<DeleteUserUseCase>(),
        deleteTokenUseCase: getIt<DeleteTokenUseCase>(),
        removePinCodeUseCase: getIt<RemovePinCodeUseCase>(),
        setUpNotificationUseCase: getIt<SetUpNotificationUseCase>(),
        initialState: AppState(
            user: getIt<UserParam>().user,
            isAuthorization:  getIt<UserParam>().user == null ? false : getIt<UserParam>().user!.firstEnter==true ? true : false  )));
    getIt.registerFactory<LanguageCubit>(() => LanguageCubit(
        getIt<ChangeLanguageUseCase>(),
        getIt<LanguageParam>().languageCode ??
            LanguageConst.getLanguageCode(sysLang)));
    getIt.registerFactory<LoginCubit>(() => LoginCubit(
        loginUseCase: getIt<LoginUseCase>(),
        insertUserUseCase: getIt<InsertUserUseCase>(),
        insertTokenUseCase: getIt<InsertTokenUseCase>(),
        initialState: const LoginState(
            stateStatus: StateStatus.initial, login: '', password: '',firebaseToken: '')));
    getIt.registerFactory<DashboardCubit>(() => DashboardCubit());
    getIt.registerFactory<NotificationCubit>(()=>NotificationCubit(
        setUpNotificationUseCase: getIt<SetUpNotificationUseCase>(),
        initialState: getIt<NotificationParam>().notification));
    getIt.registerFactory<ProfileCubit>(() => ProfileCubit(
        getProfileUseCase: getIt<GetProfileUseCase>(),
        insertUserUseCase: getIt<InsertUserUseCase>(),
        getServicesListUseCase: getIt<GetServicesListUseCase>(),
        getNotificationUseCase: getIt<GetNotificationUseCase>(),
        notificationsCountUseCase: getIt<NotificationsCountUseCase>(),
        updateProfileUseCase: getIt<UpdateProfileUseCase>()));
    getIt.registerFactory<NewsCubit>(() => NewsCubit(getIt<NewsUseCase>()));
    getIt.registerFactory<SplashCubit>(() => SplashCubit(forceUpdateUseCase: getIt<ForceUpdateUseCase>()));
    getIt.registerFactory<ChangePasswordCubit>(
        () => ChangePasswordCubit(getIt<ChangePasswordUseCase>()));
    getIt.registerFactory<AppealCubit>(
        () => AppealCubit(getIt<AppealTypesUseCase>()));
    getIt.registerFactory<AppealHistoryCubit>(
        () => AppealHistoryCubit(getIt<AppealHistoryUseCase>(),getIt<AppealHistoryByIDUseCase>()));
    getIt.registerFactory<MyCardCubit>(
        () => MyCardCubit(removeCardUseCase: getIt<RemoveCardUseCase>()));
    getIt.registerFactory<AddCardCubit>(
        () => AddCardCubit(addCardUseCase: getIt<AddCardUseCase>()));
    getIt.registerFactory<CardCubit>(
        () => CardCubit(getCardListUseCase: getIt<GetCardListUseCase>()));
    getIt.registerFactory<SupportCubit>(
        () => SupportCubit(getSupportUseCase: getIt<GetSupportUseCase>()));
    getIt.registerFactory<ConfirmationCardCubit>(() => ConfirmationCardCubit(
        confirmationCardUseCase: getIt<ConfirmationCardUseCase>()));
    getIt.registerFactory<ReplenishmentCubit>(
        () => ReplenishmentCubit(getIt<ReplenishmentUseCase>()));
    getIt.registerFactory<InvoiceListCubit>(() =>
        InvoiceListCubit(invoiceListUseCase: getIt<InvoiceListUseCase>()));
    getIt.registerFactory<InvoiceCubit>(
        () => InvoiceCubit(invoiceUseCase: getIt<InvoiceUseCase>()));
    getIt.registerFactory<PayInvoiceCubit>(
        () => PayInvoiceCubit(payInvoiceUseCase: getIt<PayInvoiceUseCase>()));
    getIt.registerFactory<CounterCubit>(() =>
        CounterCubit(getCounterListUseCase: getIt<GetCounterListUseCase>()));

    getIt.registerFactory<SurveyListCubit>(
        () => SurveyListCubit(getSurveysUseCase: getIt<GetSurveysUseCase>()));

    // initialize useCase
    getIt.registerLazySingleton<AppealHistoryUseCase>(
        () => AppealHistoryUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<AppealHistoryByIDUseCase>(
        () => AppealHistoryByIDUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ForceUpdateUseCase>(
        () => ForceUpdateUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<NotificationsCountUseCase>(
        () => NotificationsCountUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetServicesListUseCase>(
        () => GetServicesListUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<AppealTypesUseCase>(
        () => AppealTypesUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ChangeLanguageUseCase>(
        () => ChangeLanguageUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetProfileUseCase>(
        () => GetProfileUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<InsertUserUseCase>(
        () => InsertUserUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<InsertTokenUseCase>(
        () => InsertTokenUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<SetUpPinCodeUseCase>(
        () => SetUpPinCodeUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<RemovePinCodeUseCase>(
        () => RemovePinCodeUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<NewsUseCase>(
        () => NewsUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ChangePasswordUseCase>(
        () => ChangePasswordUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ChangeApartmentUseCase>(
        () => ChangeApartmentUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<PaymentHistoryUseCase>(
        () => PaymentHistoryUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<SendFileUseCase>(
        () => SendFileUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ReplenishmentDetailsUseCase>(
        () => ReplenishmentDetailsUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<CreateAppealUseCase>(
        () => CreateAppealUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ConfirmationCardUseCase>(
        () => ConfirmationCardUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<AddCardUseCase>(
        () => AddCardUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetCardListUseCase>(
        () => GetCardListUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<RemoveCardUseCase>(
        () => RemoveCardUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<ReplenishmentUseCase>(
        () => ReplenishmentUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<DeleteUserUseCase>(
        () => DeleteUserUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<DeleteTokenUseCase>(
        () => DeleteTokenUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<InvoiceListUseCase>(
        () => InvoiceListUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<InvoiceUseCase>(
        () => InvoiceUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<PayInvoiceUseCase>(
        () => PayInvoiceUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetCounterListUseCase>(
        () => GetCounterListUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<CreateInvoiceUseCase>(
        () => CreateInvoiceUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetServiceResultUseCase>(
        () => GetServiceResultUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetSupportUseCase>(
        () => GetSupportUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetSurveysUseCase>(
        () => GetSurveysUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetSurveyByIdUseCase>(
        () => GetSurveyByIdUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<SetSurveyUseCase>(
        () => SetSurveyUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetDocumentsUseCase>(
        () => GetDocumentsUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetNotificationUseCase>(
        () => GetNotificationUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<SetUpNotificationUseCase>(
        () => SetUpNotificationUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<GetPermissionUseCase>(
        () => GetPermissionUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerLazySingleton<SetPermissionUseCase>(
        () => SetPermissionUseCase(getIt<AppRepositoryImpl>()));
    getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
  } catch (error) {
    debugPrint('error ${error.toString()}');
  }
}
