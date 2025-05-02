import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../../../core/localization/loalisation.dart';
import '../../../../../core/style/dimensions.dart';

class LessonDescriptionSection extends StatelessWidget {
  final Lesson lesson;
  final bool isExpanded;
  final VoidCallback onToggleExpand;

  const LessonDescriptionSection({
    super.key,
    required this.lesson,
    required this.isExpanded,
    required this.onToggleExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: !AppTheme.islight
            ? Colors.grey.shade900.withOpacity(0.5)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: !AppTheme.islight
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            children: [
              Icon(
                Icons.description,
                size: 20,
                color: !AppTheme.islight
                    ? Colors.blue.shade300
                    : Colors.blue.shade700,
              ),
              Dimensions.widthSmall,
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ],
          ),
          Dimensions.heightMedium,
          // Description text
          GestureDetector(
            onTap: onToggleExpand,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.description ?? intl.undefined,
                  style: TextStyle(
                    fontSize: 16,
                    color: !AppTheme.islight
                        ? Colors.grey.shade300
                        : Colors.grey.shade700,
                    height: 1.5,
                  ),
                  maxLines: isExpanded ? null : 3,
                  overflow: isExpanded ? null : TextOverflow.ellipsis,
                ),
                if ((lesson.description?.length ?? 0) > 150 && !isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Voir plus',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: !AppTheme.islight
                            ? Colors.blue.shade300
                            : Colors.blue.shade700,
                      ),
                    ),
                  ),
                if (isExpanded)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Voir moins',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: !AppTheme.islight
                            ? Colors.blue.shade300
                            : Colors.blue.shade700,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
