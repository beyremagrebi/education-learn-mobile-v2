import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import '../../../utils/app/session/session_manager.dart';
import '../../../utils/app/session/token_manager.dart';
import '../api_response.dart';
import '../errors/api_exception.dart';

class ApiErrorHandler {
  static Future<ApiResponse<Data>> handleError<Data>({
    required int statusCode,
    required dynamic body,
    required String requestLog,
  }) async {
    switch (statusCode) {
      case 400: // Bad Request
        return _handleBadRequest(body, requestLog);
      case 401: // Unauthorized
        return _handleUnauthorized(body: body, requestLog: requestLog);
      case 403: // Forbidden
        return _handleForbidden(body, requestLog);
      case 404: // Not Found
        return _handleNotFound(body, requestLog);
      case 405: // Method Not Allowed
        return _handleMethodNotAllowed(body, requestLog);
      case 408: // Request Timeout
        return _handleRequestTimeout(body, requestLog);
      case 409: // Conflict
        return _handleConflict(body, requestLog);
      case 413: // Payload Too Large
        return _handlePayloadTooLarge(body, requestLog);
      case 415: // Unsupported Media Type
        return _handleUnsupportedMediaType(body, requestLog);
      case 429: // Too Many Requests
        return _handleTooManyRequests(body, requestLog);
      case 498: // Token expired/invalid (custom)
        return _handleTokenExpired(body, requestLog);
      case 500: // Internal Server Error
        return _handleInternalServerError(body, requestLog);
      case 501: // Not Implemented
        return _handleNotImplemented(body, requestLog);
      case 502: // Bad Gateway
        return _handleBadGateway(body, requestLog);
      case 503: // Service Unavailable
        return _handleServiceUnavailable(body, requestLog);
      case 504: // Gateway Timeout
        return _handleGatewayTimeout(body, requestLog);
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return _handleClientError(body, statusCode, requestLog);
        } else if (statusCode >= 500) {
          return _handleServerError(body, statusCode, requestLog);
        } else {
          return _handleUnknownError(body, statusCode, requestLog);
        }
    }
  }

// Helper for Dio transport errors
  static ApiResponse<T> handleTransportError<T>(
    DioException exception,
    String requestLog,
  ) {
    final (message, description) = switch (exception.type) {
      DioExceptionType.connectionError => (
          intl.errorConnectionFailed,
          intl.errorServer
        ),
      DioExceptionType.connectionTimeout => (
          intl.errorConnectionTimeout,
          intl.connectionError
        ),
      DioExceptionType.sendTimeout => (
          intl.errorSendTimeout,
          intl.errorPayloadTooLarge
        ),
      DioExceptionType.receiveTimeout => (
          intl.errorReceiveTimeout,
          intl.errorReceiveTimeout
        ),
      DioExceptionType.badCertificate => (
          intl.errorBadCertificate,
          intl.errorBadCertificate
        ),
      DioExceptionType.cancel => (
          intl.errorRequestCancelled,
          intl.errorRequestCancelled
        ),
      _ when exception.error is SocketException => (
          intl.errorNoInternet,
          intl.errorNetwork
        ),
      _ => (intl.errorNetwork, exception.message ?? intl.errorUnknown),
    };

    return ApiResponse.error(
      statusCode: 0, // 0 indicates transport error
      message: message,
      errorDescription: description,
      errorData: exception,
      requestLog: requestLog,
    );
  }

// Helper for generic errors
  static ApiResponse<T> handleGenericError<T>(
    Object exception,
    StackTrace stackTrace,
    String requestLog,
  ) {
    final message = switch (exception) {
      TimeoutException() => 'Timeout exceeded',
      SocketException() => 'Network error',
      ApiException() => exception.message,
      _ => exception.toString(),
    };

    return ApiResponse.error(
      statusCode: null,
      message: message,
      errorDescription: stackTrace.toString(),
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleUnknownError<Data>(
      dynamic body, int statusCode, String requestLog) {
    return ApiResponse.error(
      statusCode: statusCode,
      message: _extractErrorMessage(body) ?? intl.errorUnknown,
      errorDescription: intl.errorUnknown,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleBadRequest<Data>(
    dynamic body,
    String requestLog,
  ) {
    return ApiResponse.error(
      statusCode: 400,
      message: _extractErrorMessage(body) ?? intl.errorBadRequest,
      errorDescription: intl.errorBadRequest,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static Future<ApiResponse<Data>> _handleUnauthorized<Data>(
      {required dynamic body, required String requestLog}) async {
    await SessionManager.logout(
        errorAlertText: 'Session expired. Please login again.');
    return ApiResponse.error(
      statusCode: 401,
      message: _extractErrorMessage(body) ?? intl.errorTokenExpired,
      errorDescription: intl.errorUnauthorized,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleForbidden<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 403,
      message: _extractErrorMessage(body) ?? intl.errorMethodNotAllowed,
      errorDescription: intl.errorMethodNotAllowed,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleNotFound<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 404,
      message: _extractErrorMessage(body) ?? intl.errorNotFound,
      errorDescription: intl.errorNotFound,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleMethodNotAllowed<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 405,
      message: _extractErrorMessage(body) ?? intl.errorMethodNotAllowed,
      errorDescription: intl.errorMethodNotAllowed,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleRequestTimeout<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 408,
      message: _extractErrorMessage(body) ?? intl.errorTimeout,
      errorDescription: intl.errorReceiveTimeout,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleConflict<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 409,
      message: _extractErrorMessage(body) ?? intl.errorConflict,
      errorDescription: intl.errorConflict,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handlePayloadTooLarge<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 413,
      message: _extractErrorMessage(body) ?? intl.errorPayloadTooLarge,
      errorDescription: intl.errorPayloadTooLarge,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleUnsupportedMediaType<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 415,
      message: _extractErrorMessage(body) ?? intl.errorUnsupportedMediaType,
      errorDescription: intl.errorUnsupportedMediaType,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleTooManyRequests<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 429,
      message: _extractErrorMessage(body) ?? intl.errorTooManyRequests,
      errorDescription: intl.errorTooManyRequests,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static Future<ApiResponse<Data>> _handleTokenExpired<Data>(
      dynamic body, String requestLog) async {
    await TokenManager.refresh();
    return ApiResponse.error(
      statusCode: 498,
      message: _extractErrorMessage(body) ?? intl.errorTokenExpired,
      errorDescription: intl.errorTokenExpired,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleInternalServerError<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 500,
      message: _extractErrorMessage(body) ?? intl.errorInternalServer,
      errorDescription: intl.errorInternalServer,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleNotImplemented<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 501,
      message: _extractErrorMessage(body) ?? intl.errorNotImplemented,
      errorDescription: intl.errorNotImplemented,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleBadGateway<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 502,
      message: _extractErrorMessage(body) ?? intl.errorBadGateway,
      errorDescription: intl.errorBadGateway,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleServiceUnavailable<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 503,
      message: _extractErrorMessage(body) ?? intl.errorServiceUnavailable,
      errorDescription: intl.errorServiceUnavailable,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleGatewayTimeout<Data>(
      dynamic body, String requestLog) {
    return ApiResponse.error(
      statusCode: 504,
      message: _extractErrorMessage(body) ?? intl.errorGatewayTimeout,
      errorDescription: intl.errorGatewayTimeout,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleClientError<Data>(
      dynamic body, int statusCode, String requestLog) {
    return ApiResponse.error(
      statusCode: statusCode,
      message: _extractErrorMessage(body) ?? intl.errorClient,
      errorDescription: intl.errorClient,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static ApiResponse<Data> _handleServerError<Data>(
      dynamic body, int statusCode, String requestLog) {
    return ApiResponse.error(
      statusCode: statusCode,
      message: _extractErrorMessage(body) ?? intl.errorServer,
      errorDescription: intl.errorServer,
      errorData: body,
      requestLog: requestLog,
    );
  }

  static String? _extractErrorMessage(dynamic body) {
    if (body == null) return null;

    try {
      if (body is Map<String, dynamic>) {
        return body['message']?.toString() ??
            body['error']?.toString() ??
            body['msg']?.toString() ??
            body['err']?.toString() ??
            (body['errors'] is Map ? body['errors'].values.join(', ') : null) ??
            (body['errors'] is List ? body['errors'].join(', ') : null);
      } else if (body is String && body.length < 100) {
        return body;
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
