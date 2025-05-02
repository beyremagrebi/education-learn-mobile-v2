import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/style/themes/app_theme.dart';

class LessonCardShimmer extends StatelessWidget {
  const LessonCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: !AppTheme.islight
          ? Colors.grey.shade900.withOpacity(0.5)
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: !AppTheme.islight ? 0 : 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: AppTheme.shimmerBaseColor,
          highlightColor: AppTheme.shimmerHighlightColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and lock status row
              Row(
                children: [
                  // Lock icon placeholder
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.shimmerContentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title placeholder
                  Expanded(
                    child: Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppTheme.shimmerContentColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Subject and instructor row
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 80,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 14,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 60,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Badges row
              Row(
                children: [
                  _buildShimmerBadge(),
                  const SizedBox(width: 8),
                  _buildShimmerBadge(),
                  const SizedBox(width: 8),
                  _buildShimmerBadge(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            color: AppTheme.shimmerContentColor,
          ),
          const SizedBox(width: 4),
          Container(
            width: 40,
            height: 12,
            color: AppTheme.shimmerContentColor,
          ),
        ],
      ),
    );
  }
}
