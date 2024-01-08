import 'dart:io';

import 'package:resident/app_package/core_package.dart';

import 'package:dio/dio.dart';
import 'package:resident/app_package/data/data_source_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';

import 'package:either_dart/either.dart';
import 'package:resident/feature/data/data_source/remote_source/mixin/notifications_count_remote_source_mixin.dart';
import 'package:resident/feature/data/data_source/remote_source/mixin/support_remote_source_mixin.dart';


abstract class AppRemoteSource
    implements
        AuthRemoteSourceMixin,
        CardRemoteSourceMixin,
        CounterRemoteSourceMixin,
        NewsRemoteSourceMixin,
    NotificationsCountRemoteSourceMixin,
    SupportRemoteSourceMixin,
        AppealRemoteSourceMixin,
        PaymentRemoteSourceMixin,
        ImageRemoteSourceMixin,
        InvoiceRemoteSourceMixin,
        SurveyRemoteSourceMixin,
        DocumentRemoteSourceMixin {}

class AppRemoteSourceImpl
    with
        BaseRequest,
        AuthRemoteSourceMixin,
        CardRemoteSourceMixin,
        CounterRemoteSourceMixin,
        NotificationsCountRemoteSourceMixin,
        NewsRemoteSourceMixin,
    SupportRemoteSourceMixin,
        AppealRemoteSourceMixin,
        PaymentRemoteSourceMixin,
        ImageRemoteSourceMixin,
        InvoiceRemoteSourceMixin,
        SurveyRemoteSourceMixin,
        DocumentRemoteSourceMixin
    implements AppRemoteSource {
  final TokenDatabaseSourceMixin tokenDatabaseSourceMixin;
  bool isRefresh = false;

  AppRemoteSourceImpl(
    Dio baseAPI,
    this.tokenDatabaseSourceMixin,
  ) {
    this.baseAPI = baseAPI;
    _addInterceptor();
  }

  _addInterceptor() {
    baseAPI.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (onResponse, handler) {
        return handler.next(onResponse);
      },
      onError: (e, handler) async {
        if (!isRefresh && e.response != null && (e.response!.statusCode == 401 || e.response!.statusCode == 403)) {
          Token? databaseToken = await tokenDatabaseSourceMixin.getToken();
          if (databaseToken != null) {
            isRefresh = true;
             Either<Exception, Token> newTokenResponse = await refreshToken(
              token: databaseToken,
              cancelToken: CancelToken(),
            );

            if (newTokenResponse.isRight) {
              print("OLD Headers");
              print(e.requestOptions.headers.toString());
              print("newTokenResponse");
              print(newTokenResponse.right);
              await tokenDatabaseSourceMixin.insertToken(newTokenResponse.right);
              e.requestOptions.headers['Authorization'] = 'Bearer ${newTokenResponse.right.accessToken}';

              print("NEW Headers");
              print(e.requestOptions.headers.toString());

              try {
                final retryResponse = await retry(e.requestOptions);
                if (retryResponse.statusCode == 401 || retryResponse.statusCode == 403) {
                  isRefresh = false;
                  return handler.next(e);
                }
                isRefresh = false;
                return handler.resolve(retryResponse);
              } catch (error) {
                isRefresh = false;
                return handler.next(e);
              }
            }
            isRefresh = false;
          }
        }

        return handler.next(e);
      },
    ));
  }

  static String PROD_URL = 'https://house.dhub.uz';
  static String DEV_URL = 'https://dev-house.dhub.uz';
  static String BASE_URL = DEV_URL;

  static Dio initDio(Token? token) {
    BaseOptions options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );

    dynamic headers = {};
    headers = {
      'client-token': Platform.isAndroid?'2TV62sDk04k4D4m8qnNdtHJgs5BLToA4dWeKdydL':"jTZJAsFdrK3O84OZsrGFtCsxSu8GUs0ryS0ScWNn",
      'Content-Type': 'application/json'};

    print("token here");
    print(token.toString());

    if (token != null) {
      headers = {'Authorization': 'Bearer ${token.accessToken}'};
    }

    options.headers = headers;
    Dio dio = Dio(options);
   // dio.interceptors.add(alice.getDioInterceptor());
print("dio header");
print(dio.options.headers.toString());
    return dio;
  }
}
