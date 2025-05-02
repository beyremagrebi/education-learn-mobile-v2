import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';

class ShimmerSubjectCard extends StatelessWidget {
  const ShimmerSubjectCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.islight ? Colors.white60 : Colors.black12,
        borderRadius: Dimensions.mediumBorderRadius,
      ),
      child: Shimmer.fromColors(
        baseColor: AppTheme.shimmerBaseColor,
        highlightColor: AppTheme.shimmerHighlightColor,
        child: ExpansionTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.shimmerHighlightColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          title: Container(
            width: double.infinity,
            height: 16,
            color: AppTheme.shimmerContentColor,
          ),
          subtitle: Container(
            width: double.infinity,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            color: AppTheme.shimmerContentColor,
          ),
          trailing: Container(
            color: AppTheme.shimmerContentColor,
            height: 20,
            width: 20,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 14,
                    color: AppTheme.shimmerContentColor,
                  ),
                  Dimensions.heightSmall,
                  // Shimmer for instructors
                  Column(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.shimmerContentColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 120,
                              height: 14,
                              color: AppTheme.shimmerContentColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Dimensions.heightSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
