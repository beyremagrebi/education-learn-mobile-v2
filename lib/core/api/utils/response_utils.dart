import 'package:flutter/foundation.dart';

import '../../../utils/json_utils.dart';
import '../../base/base_model.dart';
import '../api_response.dart';

class ResponseUtils {
  static ApiResponse<Model> resolveResponse<Model extends BaseModel>(
    int statusCode,
    dynamic body, {
    required String dataKey,
    required String requestLog,
  }) {
    bool? status;
    String? message;
    dynamic data;

    if (body != null) {
      if (isValidJson(body)) {
        if (body is List) {
          data = body;
        } else if (isPaginationData(body, dataKey: dataKey)) {
          data = body;
        } else if (isDefaultResponse(body, dataKey: dataKey)) {
          status = body['status'];
          message = body['message'];
          data = body[dataKey];
        } else if (isDefaultResponseDataOnly(body, dataKey: dataKey)) {
          data = body[dataKey];
        } else if (isDefaultResponseMessageOnly(body)) {
          message = body['message'];
          data = null;
        } else if (isDefaultResponseDataAndMessage(body, dataKey: dataKey)) {
          message = body['message'];
          data = body[dataKey];
        } else if (isModel(body)) {
          data = body;
        } else {
          data = body;
        }
      } else {
        status = false;
        message = 'Response must be a json object';
        debugPrint('Response data : \n${JsonUtils.format(body)}');
      }
    } else {
      status = true;
      message = 'No data';
      debugPrint('Received data is null');
    }

    message ??= 'No message';

    if (status ?? true) {
      return ApiResponse.success(
        statusCode: statusCode,
        message: message,
        data: data,
      );
    } else {
      return ApiResponse.error(
        statusCode: statusCode,
        message: message,
        data: data,
        requestLog: requestLog,
        errorDescription: 'Request status is \'False\'',
      );
    }
  }

  static bool isValidJson(dynamic data) {
    if (data is Map || data is List) {
      return true;
    } else {
      return false;
    }
  }

  static bool isDefaultResponse(
    Map<String, dynamic> data, {
    required String dataKey,
  }) {
    return data.containsKey('status') &&
        data.containsKey('message') &&
        data.containsKey(dataKey);
  }

  static bool isDefaultResponseDataOnly(
    Map<String, dynamic> data, {
    required String dataKey,
  }) {
    return data.length == 1 || data.containsKey(dataKey);
  }

  static bool isDefaultResponseMessageOnly(Map<String, dynamic> data) {
    return data.length == 1 && data.containsKey('message');
  }

  static bool isDefaultResponseDataAndMessage(
    Map<String, dynamic> data, {
    required String dataKey,
  }) {
    return data.length == 2 &&
        data.containsKey(dataKey) &&
        data.containsKey('message');
  }

  static bool isModel(Map<String, dynamic> data) {
    return data.containsKey('_id') || data.containsKey('id');
  }

  static bool isPaginationData(
    Map<String, dynamic> data, {
    required String dataKey,
  }) {
    return (data.containsKey('pagination') || data.containsKey('page'));
  }
}
