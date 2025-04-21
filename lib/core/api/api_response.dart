import 'package:flutter/cupertino.dart';

import '../base/base_model.dart';

class ApiResponse<Data> {
  final int? statusCode;
  final String message;
  late final bool status;

  Object? data;
  String? errorDescription;
  Object? errorData;
  late String requestLog;

  ApiResponse.success({
    required this.statusCode,
    required this.message,
    required this.data,
  }) {
    status = true;
    requestLog = '';
  }

  ApiResponse.error({
    required this.statusCode,
    required this.message,
    this.data,
    required this.errorDescription,
    this.errorData,
    required this.requestLog,
  }) {
    status = false;
  }

  ApiResponse.nullResponse()
      : statusCode = 0,
        status = false,
        message = '',
        data = null,
        errorDescription = null,
        requestLog = '';

  dynamic resolveData<Model extends BaseModel>(
    Function(Map<String, dynamic>)? fromMapFunction,
  ) {
    if (data == null) {
      return null;
    } else if (data is List) {
      if (fromMapFunction != null) {
        return (data as List).map<Model>((e) => fromMapFunction(e)).toList();
      } else {
        debugPrint(
          'FromJson function is null - '
          'listData will be used instead of modelList',
        );
      }
    } else if (data is Map<String, dynamic>) {
      if (fromMapFunction != null) {
        return fromMapFunction((data as Map<String, dynamic>));
      } else {
        debugPrint(
          'FromJson function is null - '
          'mapData will be used instead of model',
        );
      }
    } else {
      debugPrint('Data type is not supported');
      debugPrint(data.runtimeType.toString());
    }
  }

  Model? resolveDataPagination<Model>(
      Model Function(Map<String, dynamic>) fromMap) {
    if (data != null && data is Map<String, dynamic>) {
      return fromMap(data as Map<String, dynamic>);
    }
    return null;
  }
}
