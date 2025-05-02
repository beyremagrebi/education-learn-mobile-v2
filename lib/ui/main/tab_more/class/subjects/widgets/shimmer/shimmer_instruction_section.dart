import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';

class ShimmerInstructionSection extends StatelessWidget {
  const ShimmerInstructionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildShimmerInstructorsSection(context);
  }

  Widget _buildShimmerInstructorsSection(BuildContext context) {
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
          padding: Dimensions.paddingSmall,
          decoration: BoxDecoration(
            color: AppTheme.islight
                ? Colors.white38
                : Colors.grey.shade800.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children:
                List.generate(2, (index) => _buildShimmerInstructorItem()),
          ),
        ),
        Dimensions.heightHuge,
      ],
    );
  }

  Widget _buildShimmerInstructorItem() {
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBaseColor,
      highlightColor: AppTheme.shimmerHighlightColor,
      child: Container(
        margin: Dimensions.paddingSmall,
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.shimmerContentColor,
                shape: BoxShape.rectangle,
                borderRadius: Dimensions.smallBorderRadius,
              ),
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
                  const SizedBox(height: 8),
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
        ),
      ),
    );
  }
}
