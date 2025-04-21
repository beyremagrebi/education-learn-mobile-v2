import 'package:flutter/material.dart';

import '../../core/style/dimensions.dart';

class TransparentShadowDecoration extends Decoration {
  final EdgeInsets insets;
  final Color? color;
  final double blurRadius;
  final bool inner;
  final BorderRadius borderRadius;
  final BoxShape shape; // Changed to BoxShape

  const TransparentShadowDecoration({
    this.insets = const EdgeInsets.all(12),
    this.color,
    this.blurRadius = 3,
    this.inner = false,
    this.borderRadius = Dimensions.largeBorderRadius,
    this.shape = BoxShape.rectangle, // Default to rectangle
  });

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) =>
      _TransparentShadowDecorationPainter(
        insets,
        color ?? Colors.grey.withOpacity(0.4),
        blurRadius,
        inner,
        borderRadius,
        shape, // Pass shape to the painter
      );
}

class _TransparentShadowDecorationPainter extends BoxPainter {
  final EdgeInsets insets;
  final Color color;
  final double blurRadius;
  final bool inner;
  final BorderRadius borderRadius;
  final BoxShape shape; // Use BoxShape

  _TransparentShadowDecorationPainter(
    this.insets,
    this.color,
    this.blurRadius,
    this.inner,
    this.borderRadius,
    this.shape,
  );

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var rect = offset & configuration.size!;

    // Expand the rect to allow painting outside the container
    var expandedRect = rect.inflate(0);

    // Create paint object with the desired shadow color and blur
    var paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, blurRadius);

    Path path;

    // Handle different shapes based on BoxShape
    if (shape == BoxShape.circle) {
      var radius = expandedRect.shortestSide / 2;
      path = Path()
        ..addOval(Rect.fromCircle(center: expandedRect.center, radius: radius));
    } else {
      // Default to rectangle, applying borderRadius
      path = Path()..addRRect(borderRadius.toRRect(expandedRect));
    }

    if (inner) {
      var innerRect = insets.inflateRect(rect);

      Path innerPath;
      if (shape == BoxShape.circle) {
        var radius = innerRect.shortestSide / 2;
        innerPath = Path()
          ..addOval(Rect.fromCircle(center: innerRect.center, radius: radius));
      } else {
        innerPath = Path()..addRRect(borderRadius.toRRect(innerRect));
      }

      var fullPath = Path()
        ..fillType = PathFillType.evenOdd
        ..addPath(path, Offset.zero)
        ..addPath(innerPath, Offset.zero);

      canvas.drawPath(fullPath, paint);
    } else {
      canvas.drawPath(path, paint);
    }
  }
}
