import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

class ShimmerClassCard extends StatelessWidget {
  const ShimmerClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBaseColor,
      highlightColor: AppTheme.shimmerHighlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.shimmerContentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class name with icon (shimmer version)
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.shimmerContentColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 20,
                      height: 20,
                      color: AppTheme.shimmerContentColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppTheme.shimmerContentColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // Period with calendar icon (shimmer version)
              Row(
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 100,
                    height: 12,
                    color: AppTheme.shimmerContentColor,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Students count with people icon (shimmer version)
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: AppTheme.shimmerContentColor,
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 80,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Gender distribution bar (shimmer version)
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.shimmerContentColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.shimmerContentColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // View details button (shimmer version)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.shimmerContentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: 60,
                    height: 12,
                    color: AppTheme.shimmerContentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
