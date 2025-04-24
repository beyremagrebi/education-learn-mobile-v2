import 'dart:async';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';

import '../../utils/app/session/token_manager.dart';
import '../base/base_api_file.dart';
import 'api_response.dart';
import 'handler/api_error_handler.dart';
import 'log/api_logger.dart';
import 'handler/api_request_builder.dart';
import 'handler/api_response_handler.dart';

enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  final String description;

  const HttpMethod(this.description);
}

class ApiService {
  static bool noInternet = false;

  static Future<ApiResponse<Data>> call<Data>({
    required final String url,
    required final HttpMethod httpMethod,
    final bool authIsRequired = true,
    final bool isForChild = false,
    Map<String, String>? headers,
    final bool displayAlert = true,
    final Map<String, dynamic>? queryParameters,
    final Map<String, Object>? body,
    final List<dynamic>? listBody,
    final String? dataKey,
    final bool isMultipart = false,
    final BaseApiFile? apiFile,
    final ProgressCallback? onSendProgress,
  }) async {
    String? requestLog;

    try {
      // Build request components
      final isMultipartRequest = isMultipart || apiFile != null;
      final headers = await ApiRequestBuilder.buildHeaders(
        authIsRequired: authIsRequired,
        isForChild: isForChild,
      );
      final data = await ApiRequestBuilder.buildRequestData(
        isMultipart: isMultipartRequest,
        body: body,
        listBody: listBody,
        apiFile: apiFile,
      );

      // Configure Dio
      final dio = _configureDio(authIsRequired);

      // Make the request
      final response = await dio.request(
        url,
        data: data,
        queryParameters: queryParameters
          ?..removeWhere((key, value) => value == null),
        options: Options(
          headers: headers,
          method: httpMethod.description,
          contentType:
              isMultipartRequest ? 'multipart/form-data' : 'application/json',
        ),
        onSendProgress: onSendProgress,
      );

      // Log the request
      requestLog = ApiLogger.logRequest(
        url: url,
        httpMethod: httpMethod,
        isMultipart: isMultipartRequest,
        statusCode: response.statusCode,
        requestBody: body?.toString(),
        queryParameters: queryParameters?.toString(),
        responseBody: response.data?.toString(),
      );

      dio.close();

      // Handle response
      return ApiResponseHandler.handleSuccess(
        body: response.data,
        statusCode: response.statusCode ?? 200,
        dataKey: dataKey,
        requestLog: requestLog,
      );
    } catch (exception, stackTrace) {
      return _handleException(
        exception: exception,
        stackTrace: stackTrace,
        url: url,
        httpMethod: httpMethod,
        isMultipart: isMultipart || apiFile != null,
        body: body,
        requestLog: requestLog ?? 'Request error',
      );
    }
  }

  static Dio _configureDio(bool authIsRequired) {
    final dio = Dio();

    // Use the synchronous version of _getCacheOptions
    dio.interceptors.addAll([
      DioCacheInterceptor(options: _getCacheOptionsSync()),
      InterceptorsWrapper(
        onRequest: (requestOption, handler) => handler.next(requestOption),
        onResponse: (response, handler) => handler.next(response),
        onError: (dioException, handler) => _handleDioError(
          dioException,
          handler,
          authIsRequired,
          dio,
        ),
      ),
    ]);

    return dio;
  }

  static Future<void> _handleDioError(
    DioException dioException,
    ErrorInterceptorHandler handler,
    bool authIsRequired,
    Dio dio, // Pass Dio instance here
  ) async {
    if (dioException.response?.statusCode == 498) {
      await TokenManager.refresh();
      final headers =
          await ApiRequestBuilder.buildHeaders(authIsRequired: authIsRequired);
      final response = await dio.request(
        dioException.requestOptions.path,
        data: dioException.requestOptions.data,
        queryParameters: dioException.requestOptions.queryParameters
          ..removeWhere((key, value) => value == null),
        options: Options(
          extra: dioException.requestOptions.extra,
          headers: headers,
          method: dioException.requestOptions.method,
          contentType: dioException.requestOptions.contentType,
        ),
      );
      return handler.resolve(response);
    }
    return handler.next(dioException);
  }

  static CacheOptions _getCacheOptionsSync() {
    final tempDir = Directory.systemTemp.path;
    return CacheOptions(
      store: HiveCacheStore(tempDir),
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      allowPostMethod: false,
    );
  }

  static Future<ApiResponse<T>> _handleException<T>({
    required Object exception,
    required StackTrace stackTrace,
    required String url,
    required HttpMethod httpMethod,
    required bool isMultipart,
    required Map<String, dynamic>? body,
    required String requestLog,
  }) async {
    if (exception is DioException) {
      if (exception.response != null) {
        requestLog = ApiLogger.logRequest(
          url: url,
          httpMethod: httpMethod,
          isMultipart: isMultipart,
          statusCode: exception.response?.statusCode,
          requestBody: body?.toString(),
          queryParameters: null,
          responseBody: exception.response?.data?.toString(),
        );
        return ApiErrorHandler.handleError(
          statusCode: exception.response!.statusCode!,
          body: exception.response!.data,
          requestLog: requestLog,
        );
      }

      // 1b. Handle transport-level Dio errors
      return ApiErrorHandler.handleTransportError(exception, requestLog);
    }

    if (kDebugMode) print(exception);
    // 2. Handle other exception types
    return ApiErrorHandler.handleGenericError(
        exception, stackTrace, requestLog);
  }
}
