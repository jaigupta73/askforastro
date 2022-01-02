import 'dart:convert';

import 'package:askforastro/util/utils.dart';
import 'package:dio/dio.dart';

import 'package:dio_http_cache/dio_http_cache.dart';

import 'logging_interceptor.dart';

class DioMethod {
  static Dio _getDioConfiguration({
    String contentType = '',
    bool cacheAllowed = false,
  }) {
    String appBaseURL = 'https://www.astrotak.com/';

    BaseOptions options = BaseOptions(
      baseUrl: appBaseURL,
      connectTimeout: 60000,
      receiveTimeout: 60000,
      sendTimeout: 60000,
    );
    if (contentType.isNotEmpty) {
      options.contentType = contentType;
    }

    Dio dio = Dio();
    dio.options = options;
    dio.interceptors.add(LoggingInterceptor());

    if (cacheAllowed) {
      dio.interceptors
          .add(DioCacheManager(CacheConfig(baseUrl: appBaseURL)).interceptor);
    }

    return dio;
  }

  static Future<Map<String, dynamic>?> dioGet(
    String url, {
    Map<String, dynamic> queryParams = const {},
    String contentType = '',
    bool retryApiCall = false,
  }) async {
    try {
      Response response =
          await _getDioConfiguration(contentType: contentType).get(
        url,
        queryParameters: queryParams,
      );
      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioError catch (error) {
      appLog(error);
      if (retryApiCall) {
        appLog('Retrying Api call');
        return await dioGet(url,
            queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    } catch (e) {
      appLog(e);
      if (retryApiCall) {
        appLog('Retrying Api call');
        return await dioGet(url,
            queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    }
  }

  static Future<Map<String, dynamic>?> dioPost(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic> queryParams = const {},
    String contentType = '',
    bool retryApiCall = false,
  }) async {
    // FirebaseCrashlytics.instance.setCustomKey('API Request', url);
    try {
      Response response =
          await _getDioConfiguration(contentType: contentType).post(
        url,
        data: jsonEncode(data),
        queryParameters: queryParams,
      );

      // FirebaseCrashlytics.instance.setCustomKey('API Response', response.data.toString());

      return response.data != null
          ? response.data is Map
              ? response.data
              : jsonDecode(response.data)
          : null;
    } on DioError catch (error) {
      appLog(error);
      if (retryApiCall != null && retryApiCall) {
        appLog('Retrying Api call');
        return await dioPost(url, data,
            queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    } catch (e) {
      appLog(e);
      if (retryApiCall != null && retryApiCall) {
        appLog('Retrying Api call');
        return await dioPost(url, data,
            queryParams: queryParams, contentType: contentType);
      } else {
        return null;
      }
    }
  }
}
