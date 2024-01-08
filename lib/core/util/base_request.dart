import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/core/error/exception.dart';


dynamic jsonToBaseResponsePaginationList<T>(Response responseBody) {
  return BasePaginationListResponse<T>.fromJson(
      responseBody.data as Map<String, dynamic>, (json) {
    return jsonToEntity<T>(json as Map<String, dynamic>);
  });
}

// dynamic jsonToBaseResponseList<T>(Response responseBody) {
//   return BaseListResponse<T>.fromJson(responseBody.data as Map<String, dynamic>,
//       (json) {
//     return jsonToEntity<T>(json as Map<String, dynamic>);
//   });
// }

dynamic jsonToBaseResponse<T>(Response responseBody) {
  print("DATA");
  print(responseBody.data);
  return BaseResponse<T>.fromJson(responseBody.data as Map<String, dynamic>,
      (json) {
    print("AAA $json");
    if(json is bool)
      return json as T;
    else
    return jsonToEntity<T>(json as Map<String, dynamic>);
  });
}

dynamic jsonToEntity<T>(Map<String, dynamic> data) {
  switch (T) {
    case bool:
      return data["data"] as T;
    case User:
      return User.fromJson(data) as T;
    case Token:
      return Token.fromJson(data) as T;
    case AuthResponse:
      return AuthResponse.fromJson(data) as T;
    case Newness:
      return Newness.fromJson(data) as T;
    case NotificationsCount:
      return NotificationsCount.fromJson(data) as T;
    case AppealResponse:
      return AppealResponse.fromJson(data) as T;
    case AppealType:
      return AppealType.fromJson(data) as T;
    case ImageFile:
      return ImageFile.fromJson(data) as T;
      case Support:
      return Support.fromJson(data) as T;
    case Payment:
      return Payment.fromJson(data) as T;
    case ReplenishmentDetailsResponse:
      return ReplenishmentDetailsResponse.fromJson(data) as T;
    case SmsCardResponse:
      return SmsCardResponse.fromJson(data) as T;
    case ServiceResult:
      return ServiceResult.fromJson(data) as T;
    case CardResponse:
      return CardResponse.fromJson(data) as T;
    case Counter:
      return Counter.fromJson(data) as T;
    case Invoice:
      return Invoice.fromJson(data) as T;
    case Survey:
      return Survey.fromJson(data) as T;
    case SurveyList:
      return SurveyList.fromJson(data) as T;
    case Document:
      return Document.fromJson(data) as T;
    default:
      return null;
  }
}

mixin BaseRequest {
  late final Dio baseAPI;

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return baseAPI.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> addToken(Token token) async {
    Map<String, dynamic> headers = baseAPI.options.headers;
    headers['Authorization'] = 'Bearer ${token.accessToken}';
   // headers.remove('client-token');
    baseAPI.options.headers = headers;
  }

  Future<void> removeToken() async {
    baseAPI.options.headers.remove('Authorization');
  }

  Future<Either<Exception, dynamic>> parseJson<T>(
      Response response) async {
    try {

      if (response.data["current_page"] != null) {
        BasePaginationListResponse parsedResponse = await jsonToBaseResponsePaginationList<T>(response);
        if(parsedResponse.statusCode==0) {
          return Right(parsedResponse);

        }
        else {
          return Left(ServerException(statusCode: parsedResponse.statusCode,message: parsedResponse.statusMessage));
        }

      } else if (response.data["status_code"] != null) {
        BaseResponse parsedResponse = await jsonToBaseResponse<T>(response);
        if(parsedResponse.statusCode==0) {
          return Right(parsedResponse);
        }
        else {
          return Left(ServerException(statusCode: parsedResponse.statusCode,message: parsedResponse.statusMessage));
        }
      }
      return Right(
          await jsonToEntity<T>(response.data as Map<String, dynamic>));
    } catch (error) {
      print(error.toString());
      return Left(JsonCastException(message: error.toString()));
    }
  }

  Future<Either<Exception, dynamic>> _request(Future<dynamic> request) async {
    try {
      return Right(await request);
    } on DioError catch (dioError) {
      print("DIOERRORTYPE ${dioError.type}");
      if (dioError.type == DioErrorType.badResponse) {
        print("DioErrorType.response");
        if (dioError.response!.statusCode == 401 ||
            dioError.response!.statusCode == 403) {
          print("TokenExpireException");
          return Left(TokenExpireException());
        }
        else if (dioError.response != null &&
            dioError.response?.data != null) {
          print("ServerException");
          return Left(ServerException(
            statusCode: dioError.response!.statusCode,
            message: dioError.response!.data != null &&
                    dioError.response!.data != '' &&
                    dioError.response!.data['status_message'] != null
                ? Message.fromJson(dioError.response?.data['status_message'])
                : null,
          ));
        }
      }

      else if(dioError.type == DioErrorType.cancel) {
        return Left(CancelException());
      }

      else if (dioError.type == DioErrorType.connectionTimeout ||
          dioError.type == DioErrorType.receiveTimeout ||
          dioError.type == DioErrorType.sendTimeout) {
        return Left(ConnectionTimeOutException());
      }
      return Left(NetworkException());
    } on SocketException {
      return Left(NetworkException());
    } catch (e) {
      return Left(JsonCastException(message: e.toString()));
    }
  }

  Future<Either<Exception, dynamic>> get(
    String url, {
    dynamic queryParameters,
    required CancelToken cancelToken,
  }) async {
    return _request(baseAPI.get(url,
        queryParameters: queryParameters, cancelToken: cancelToken));
  }

  Future<Either<Exception, dynamic>> post(
    String url, {
    dynamic queryParameters,
    dynamic data,
    dynamic headers,
    required CancelToken cancelToken,
  }) async {
    if (headers != null) {
      baseAPI.options.headers = headers;
    }

    return _request(baseAPI.post(
      url,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    ));
  }

  Future<Either<Exception, dynamic>> put(
    String url, {
    dynamic queryParameters,
    dynamic data,
    dynamic headers,
    required CancelToken cancelToken,
  }) async {
    if (headers != null) {
      baseAPI.options.headers = headers;
    }

    return _request(baseAPI.put(
      url,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    ));
  }

  Future<Either<Exception, dynamic>> delete(
    String url, {
    dynamic queryParameters,
    dynamic data,
    dynamic headers,
    required CancelToken cancelToken,
  }) async {
    if (headers != null) {
      baseAPI.options.headers = headers;
    }

    return _request(baseAPI.delete(
      url,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
    ));
  }

  Future<dynamic> upload(String url, {data, options}) async {
    // return await _request(
    //     () => baseAPI.delete(url, data: data, options: options));
  }
}
