import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import '../api/api_response.dart';
import '../api/errors/api_exception.dart';
import '../api/utils/pagination_response.dart';
import '../enums/api_status.dart';
import 'base_model.dart';

typedef Completion = void Function(bool success);

abstract class BaseViewModel extends ChangeNotifier {
  BuildContext context;

  BaseViewModel(this.context, {this.isBusy = false});

  bool isBusy;
  bool isDisposed = false;

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  void update() {
    if (!isDisposed) {
      notifyListeners();
    } else {
      debugPrint(
        'NotifyListeners is being called while the view model is disposed',
      );
    }
  }

  ApiStatus apiStatus<T>(T? data, {bool? isEmpty}) {
    return data != null
        ? ApiStatus.success
        : isBusy
            ? ApiStatus.loading
            : isEmpty ?? false
                ? ApiStatus.success
                : ApiStatus.error;
  }

  bool isLoading<T>(T? data) => data != null ? false : isBusy;

  Future<void> makeApiCall<Data, Model extends BaseModel>({
    required Model Function(Map<String, dynamic>)? fromMapFunction,
    required Future<ApiResponse<Data>> apiCall,
    Function(Data? data)? onSuccess,
    Function(Data? data, String message)? onSuccessWithMessage,
    Function(String message)? onError,
    bool alertOnError = true,
    bool notifyLoading = true,
    bool displayLoadingIndicator = false,
  }) async {
    if (displayLoadingIndicator) context.loaderOverlay.show();

    if (notifyLoading) {
      isBusy = true;
      if (!isDisposed) update();
    }

    try {
      final jsonResponse = await apiCall;

      if (jsonResponse.status) {
        final data = jsonResponse.resolveData<Model>(fromMapFunction);

        await onSuccess?.call(data);
        await onSuccessWithMessage?.call(data, jsonResponse.message);
      } else {
        if (alertOnError) {
          if (context.mounted) {
            // AlertUtils.showErrorDialog(
            //   context: context,
            //   title: _getErrorMessage(statusCode: jsonResponse.statusCode),
            //   description: jsonResponse.message,
            //   detailsFunction: () => _displayStack(
            //     jsonResponse.errorDescription,
            //     requestLog: jsonResponse.requestLog,
            //     errorData: jsonResponse.errorData,
            //   ),
            // );
          }
        }

        debugPrint('Backend responded with status = ${jsonResponse.status}');
        debugPrint('Message = ${jsonResponse.message}');

        onError?.call(jsonResponse.message);
      }
    } catch (exception, stackTrace) {
      int? statusCode;

      if (exception is ApiException) {
        statusCode = exception.statusCode;
        //TODO alert diagold
        // AlertUtils.showErrorDialog(
        //   title: _getErrorMessage(statusCode: statusCode),
        //   description: exception.message,
        //   detailsFunction: () => _displayStack(
        //     '${exception.message}\n${stackTrace.toString()}',
        //   ),
        // );
      }

      debugPrint('Network error : $exception');
      debugPrintStack(stackTrace: stackTrace);

      onError?.call(
        _getErrorMessage(statusCode: statusCode, exception: exception),
      );
    }

    if (notifyLoading) isBusy = false;
    if (!isDisposed) update();

    if (context.mounted && displayLoadingIndicator) {
      context.loaderOverlay.hide();
    }
  }

  String _getErrorMessage({
    required int? statusCode,
    Object? exception,
  }) {
    return ' ${intl.genericError}'
        '${statusCode != null ? ' ($statusCode)' : ''}'
        '${exception != null ? ' : $exception' : ''}';
  }

  Future<void> makeApiCallPagination<Data, Model extends BaseModel>({
    required Model Function(Map<String, dynamic>) fromMapFunction,
    required Future<ApiResponse<Data>> apiCall,
    Function(PaginatedResponse<Model>? paginatedData)? onSuccess,
    Function(PaginatedResponse<Model>? paginatedData, String message)?
        onSuccessWithMessage,
    Function(String message)? onError,
    bool alertOnError = true,
    bool notifyLoading = true,
    bool displayLoadingIndicator = false,
  }) async {
    if (displayLoadingIndicator) context.loaderOverlay.show();

    if (notifyLoading) {
      isBusy = true;
      if (!isDisposed) update();
    }

    try {
      final jsonResponse = await apiCall;

      if (jsonResponse.status) {
        final paginatedData =
            jsonResponse.resolveDataPagination<PaginatedResponse<Model>>(
          (json) => PaginatedResponse<Model>.fromMap(
              json, (item) => fromMapFunction(item)),
        );
        await onSuccess?.call(paginatedData);
        await onSuccessWithMessage?.call(paginatedData, jsonResponse.message);
      } else {
        if (alertOnError) {
          // AlertUtils.showErrorDialog(
          //   title: _getErrorMessage(statusCode: jsonResponse.statusCode),
          //   description: jsonResponse.message,
          //   detailsFunction: () => _displayStack(
          //     jsonResponse.errorDescription,
          //     requestLog: jsonResponse.requestLog,
          //     errorData: jsonResponse.errorData,
          //   ),
          // );
        }

        debugPrint('Backend responded with status = ${jsonResponse.status}');
        debugPrint('Message = ${jsonResponse.message}');

        onError?.call(jsonResponse.message);
      }
    } catch (exception, stackTrace) {
      int? statusCode;

      if (exception is ApiException) {
        statusCode = exception.statusCode;

        // AlertUtils.showErrorDialog(
        //   title: _getErrorMessage(statusCode: statusCode),
        //   description: exception.message,
        //   detailsFunction: () => _displayStack(
        //     '${exception.message}\n${stackTrace.toString()}',
        //   ),
        // );
      }

      debugPrint('Network error : $exception');
      debugPrintStack(stackTrace: stackTrace);

      onError?.call(
        _getErrorMessage(statusCode: statusCode, exception: exception),
      );
    }

    if (notifyLoading) isBusy = false;
    if (!isDisposed) update();

    if (context.mounted && displayLoadingIndicator) {
      context.loaderOverlay.hide();
    }
  }
}
