import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';

class ShimmerResource extends StatelessWidget {
  const ShimmerResource({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppTheme.shimmerBaseColor,
          highlightColor: AppTheme.shimmerHighlightColor,
          child: Container(
            width: 120,
            height: 20,
            color: AppTheme.shimmerContentColor,
          ),
        ),
        Dimensions.heightLarge,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.islight
                ? Colors.white38
                : Colors.grey.shade800.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: _buildShimmerEffect(),
        ),
        Dimensions.heightHuge,
      ],
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBaseColor,
      highlightColor: AppTheme.shimmerHighlightColor,
      child: Column(
        children: [
          for (var i = 0; i < 2; i++) ...[
            _buildShimmerResourceItem(),
            if (i != 1) const Divider(height: 24, color: Colors.transparent),
          ],
        ],
      ),
    );
  }

  Widget _buildShimmerResourceItem() {
    return Row(
      children: [
        Container(
          padding: Dimensions.paddingSmall,
          decoration: BoxDecoration(
            color: AppTheme.shimmerContentColor,
            borderRadius: BorderRadius.circular(8),
          ),
          width: 40,
          height: 40,
        ),
        Dimensions.widthLarge,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 16,
                color: AppTheme.shimmerContentColor,
              ),
              const SizedBox(height: 4),
              Container(
                width: 100,
                height: 12,
                color: AppTheme.shimmerContentColor,
              ),
            ],
          ),
        ),
        Container(
          width: 24,
          height: 24,
          color: AppTheme.shimmerContentColor,
        ),
      ],
    );
  }
}
