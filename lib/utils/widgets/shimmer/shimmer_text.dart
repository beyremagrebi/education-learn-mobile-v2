import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

class ShimmerText extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerText.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerText.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBaseColor,
      highlightColor: AppTheme.shimmerHighlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: AppTheme.shimmerContentColor,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
