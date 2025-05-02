import 'package:flutter/material.dart';

import '../../../core/enums/api_status.dart';
import '../loading/loading_widget.dart';
import 'error_widget.dart';

class AsyncBuilder extends StatelessWidget {
  final ApiStatus apiStatus;
  final Widget? loadingWidget;
  final Future Function()? refreshFunction;
  final Widget Function() onSuccess;
  final bool displayIfNull;
  final String? errorMessage;
  final String? errorTitle;
  final bool isDarkMode;

  const AsyncBuilder({
    super.key,
    required this.apiStatus,
    required this.loadingWidget,
    required this.refreshFunction,
    required this.onSuccess,
    this.displayIfNull = false,
    this.errorMessage,
    this.errorTitle,
    this.isDarkMode = true,
  });

  @override
  Widget build(BuildContext context) {
    if (displayIfNull) return onSuccess.call();

    switch (apiStatus) {
      case ApiStatus.success:
        return onSuccess.call();
      case ApiStatus.loading:
        return loadingWidget ??
            const LoadingWidget(
              size: 30,
            );
      case ApiStatus.error:
        debugPrint('Data is null');
        return ErrorDisplayWidget(
          message: errorMessage,
          title: errorTitle,
          onRetry: refreshFunction,
        );
    }
  }
}
