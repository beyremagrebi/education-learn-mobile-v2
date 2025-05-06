import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';
import 'package:studiffy/ui/main/tab_more/class/subjects/subject_details_view.dart';
import 'package:studiffy/utils/color_utils.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../../../../../core/localization/loalisation.dart';

class LessonSubjectSection extends StatelessWidget {
  final Lesson lesson;

  const LessonSubjectSection({super.key, required this.lesson});

  Color _getSubjectColor() {
    final int hash = lesson.subject!.name.hashCode.abs();
    final List<Color> colors = [
      Colors.blue.shade700,
      Colors.purple.shade700,
      Colors.green.shade700,
      Colors.orange.shade700,
      Colors.pink.shade700,
      Colors.teal.shade700,
      Colors.indigo.shade700,
      Colors.red.shade700,
    ];
    return colors[hash % colors.length];
  }

  void _navigateToSubject(BuildContext context) {
    navigateTo(
      context,
      SubjectDetailsView(
        subjectId: lesson.subject?.id,
        iconColor:
            ColorUtils.getSubjectColor(lesson.subject?.name ?? intl.undefined),
      ),
    );
  }

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
                Icons.book,
                size: 20,
                color: !AppTheme.islight
                    ? Colors.teal.shade300
                    : Colors.teal.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                intl.subjects,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Subject info
          Row(
            children: [
              // Subject icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getSubjectColor()
                      .withOpacity(!AppTheme.islight ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.subject,
                  color: _getSubjectColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              // Subject details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.subject?.name ?? intl.undefined,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: !AppTheme.islight
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${intl.classMenu}: ${lesson.classe?.name}',
                      style: TextStyle(
                        fontSize: 14,
                        color: !AppTheme.islight
                            ? Colors.grey.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              // View subject button
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: !AppTheme.islight
                      ? Colors.blue.shade300
                      : Colors.blue.shade700,
                ),
                onPressed: () => _navigateToSubject(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
