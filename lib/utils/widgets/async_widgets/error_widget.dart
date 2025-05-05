import 'package:flutter/material.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/utils/widgets/from/buttons/custum_filled_button.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final Future Function()? onRetry;

  const ErrorDisplayWidget({
    super.key,
    this.message,
    this.title,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = !AppTheme.islight;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: Dimensions.smallBorderRadius,
                color: isDark
                    ? Colors.red.shade900.withOpacity(0.2)
                    : Colors.red.shade700.withOpacity(0.2),
                shape: BoxShape.rectangle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: isDark ? Colors.red.shade300 : Colors.red.shade700,
              ),
            ),
            Dimensions.heightMedium,
            // Error title
            Text(
              title ?? intl.errorTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey.shade800,
              ),
              textAlign: TextAlign.center,
            ),

            // Error message
            Text(
              message ?? intl.errorMessage,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.grey.shade300 : Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),

            // Retry button
            if (onRetry != null) ...[
              Dimensions.heightMedium,
              CustomFilledButton(
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.refresh),
                      Text(intl.retryButton)
                    ],
                  ),
                  onPressed: onRetry)
            ]
          ],
        ),
      ),
    );
  }
}
