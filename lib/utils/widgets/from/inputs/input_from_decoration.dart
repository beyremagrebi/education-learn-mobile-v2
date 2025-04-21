import 'package:flutter/material.dart';

import '../../../../core/style/dimensions.dart';
import '../../../../core/style/themes/app_colors.dart';

import '../../transparent_shadow_decoration.dart';

class InputFormDecoration extends StatelessWidget {
  final String? label;
  final EdgeInsets? padding;
  final bool isCircular;
  final bool hasError;
  final Widget child;
  final Color? borderColor;
  final Color? shadowColor;

  const InputFormDecoration({
    super.key,
    required this.label,
    required this.padding,
    required this.isCircular,
    required this.hasError,
    this.borderColor,
    this.shadowColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: TransparentShadowDecoration(
            borderRadius: isCircular
                ? BorderRadius.circular(300)
                : Dimensions.largeBorderRadius,
            color: shadowColor,
            shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              borderRadius: isCircular ? null : Dimensions.largeBorderRadius,
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: isCircular ? null : Dimensions.largeBorderRadius,
              shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
              border: Border.all(
                color: hasError
                    ? dangerColor
                    : borderColor ?? Theme.of(context).colorScheme.surface,
              ),
            ),
            child: child,
          ),
        ),
        if (label != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Text(
              label!,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
      ],
    );
  }
}
