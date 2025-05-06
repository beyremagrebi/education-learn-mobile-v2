import 'package:flutter/material.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../../../../core/localization/loalisation.dart';
import '../../../../core/style/themes/app_theme.dart';
import '../../../../models/training_center/lesson/lesson.dart';
import '../lesson_details_view.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return _buildLessonCard(context, lesson);
  }

  int getQuizzesCount() {
    int totalQuizzes = 0;

    if (lesson.chapters.isNotEmptyAndNotNull) {
      for (var chapter in lesson.chapters!) {
        totalQuizzes += chapter.quizzes?.length ?? 0;
      }
    }

    return totalQuizzes;
  }

  Widget _buildLessonCard(BuildContext context, Lesson lesson) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: !AppTheme.islight
          ? Colors.grey.shade900.withOpacity(0.5)
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: !AppTheme.islight ? 0 : 2,
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            LessonDetailsView(
              lesson: lesson,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: Dimensions.paddingMedium,
                    decoration: BoxDecoration(
                      color: lesson.isLocked ?? false
                          ? (!AppTheme.islight
                              ? Colors.red.shade900.withOpacity(0.2)
                              : Colors.red.shade50)
                          : (!AppTheme.islight
                              ? Colors.green.shade900.withOpacity(0.2)
                              : Colors.green.shade50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      lesson.isLocked ?? false ? Icons.lock : Icons.lock_open,
                      color: lesson.isLocked ?? false
                          ? (!AppTheme.islight
                              ? Colors.red.shade300
                              : Colors.red.shade700)
                          : (!AppTheme.islight
                              ? Colors.green.shade300
                              : Colors.green.shade700),
                      size: 16,
                    ),
                  ),
                  Dimensions.widthMedium,
                  // Title
                  Expanded(
                    child: Text(
                      lesson.title ?? intl.undefined,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: !AppTheme.islight
                            ? Colors.white
                            : Colors.grey.shade800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Dimensions.heightMedium,
              Row(
                children: [
                  Icon(
                    Icons.book,
                    size: 14,
                    color: !AppTheme.islight
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                  Dimensions.widthSmall,
                  Text(
                    lesson.subject?.name ?? intl.undefined,
                    style: TextStyle(
                      fontSize: 14,
                      color: !AppTheme.islight
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                  Dimensions.widthMedium,
                  Icon(
                    Icons.person,
                    size: 14,
                    color: !AppTheme.islight
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                  Dimensions.widthSmall,
                  Text(
                    lesson.instructor?.firstName ?? intl.undefined,
                    style: TextStyle(
                      fontSize: 14,
                      color: !AppTheme.islight
                          ? Colors.grey.shade400
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              Dimensions.heightMedium,
              // Materials and quizzes count
              Row(
                children: [
                  _buildInfoBadge(
                    context,
                    Icons.description,
                    '${lesson.chapters?.length} ${intl.chapters}',
                    !AppTheme.islight
                        ? Colors.blue.shade900
                        : Colors.blue.shade50,
                    !AppTheme.islight
                        ? Colors.blue.shade300
                        : Colors.blue.shade700,
                    lesson.chapters.isEmptyOrNull,
                  ),
                  Dimensions.widthSmall,
                  _buildInfoBadge(
                    context,
                    Icons.quiz,
                    '${getQuizzesCount()} ${intl.quiz}',
                    !AppTheme.islight
                        ? Colors.purple.shade900
                        : Colors.purple.shade50,
                    !AppTheme.islight
                        ? Colors.purple.shade300
                        : Colors.purple.shade700,
                    getQuizzesCount() == 0,
                  ),
                  Dimensions.widthSmall,
                  _buildInfoBadge(
                    context,
                    Icons.videocam,
                    intl.meeting,
                    !AppTheme.islight
                        ? Colors.red.shade900
                        : Colors.red.shade50,
                    !AppTheme.islight
                        ? Colors.red.shade300
                        : Colors.red.shade700,
                    lesson.meetCode == null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoBadge(
    BuildContext context,
    IconData icon,
    String label,
    Color bgColor,
    Color fgColor,
    bool isDiabled,
  ) {
    return Opacity(
      opacity: isDiabled ? 0.5 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor.withOpacity(!AppTheme.islight ? 0.3 : 1.0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: fgColor,
            ),
            Dimensions.widthSmall,
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: fgColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
