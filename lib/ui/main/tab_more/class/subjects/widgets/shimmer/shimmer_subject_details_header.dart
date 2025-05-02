import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

import '../../../../../../../core/style/dimensions.dart';

class ShimmerSubjectDetailsHeader extends StatelessWidget {
  const ShimmerSubjectDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBaseColor,
      highlightColor: AppTheme.shimmerHighlightColor,
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppTheme.shimmerContentColor,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Dimensions.widthMedium,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  height: 24,
                  color: AppTheme.shimmerContentColor,
                ),
                Dimensions.heightMedium,
                Container(
                  width: 150,
                  height: 14,
                  color: AppTheme.shimmerContentColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
