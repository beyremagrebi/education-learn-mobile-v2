import 'package:flutter/material.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? message;
  final String? buttonText;
  final IconData? icon;
  final VoidCallback? onRefresh;

  final Color? textColor;
  final String? title;

  const EmptyDataWidget({
    super.key,
    this.message,
    this.buttonText,
    this.icon,
    this.onRefresh,
    this.textColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = !AppTheme.islight;
    final effectiveTextColor =
        textColor ?? (isDark ? Colors.white : Colors.grey.shade800);

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.grey.shade800.withOpacity(0.3)
                    : Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.inbox_outlined,
                size: 50,
                color: isDark ? Colors.grey.shade400 : Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),

            // Title
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: effectiveTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            // Message
            Text(
              message ?? intl.noDataAvailable,
              style: TextStyle(
                fontSize: 16,
                color: effectiveTextColor.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Refresh button
            if (onRefresh != null)
              ElevatedButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh),
                label: Text(
                  buttonText ?? intl.retryButton,
                ),
                style: Theme.of(context).filledButtonTheme.style?.copyWith(
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
