import 'package:flutter/material.dart';

import '../../base/base_model.dart';
import '../api_response.dart';
import '../utils/response_utils.dart';

class ApiResponseHandler {
  static ApiResponse<Model> handleSuccess<Model extends BaseModel>({
    required dynamic body,
    required int statusCode,
    required String? dataKey,
    required String requestLog,
  }) {
    try {
      return ResponseUtils.resolveResponse(
        statusCode,
        body,
        dataKey: dataKey ?? 'data',
        requestLog: requestLog,
      );
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stackTrace);

      return ApiResponse.nullResponse();
    }
  }
}
