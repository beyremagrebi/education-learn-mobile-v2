import 'package:flutter/material.dart';

import '../../../custum_circular_progress.dart';
import 'custum_filled_button.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFilledButton(
      onPressed: isLoading ? null : onPressed,
      widget: isLoading
          ? const CustomCircularProgressIndicator(
              strokeWidth: 2,
              widthAndHeight: 20,
            )
          : child,
    );
  }
}
