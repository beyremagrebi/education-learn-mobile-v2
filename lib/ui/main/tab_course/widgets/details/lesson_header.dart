import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../../../core/localization/loalisation.dart';
import '../../../../../core/style/dimensions.dart';

class LessonHeader extends StatelessWidget {
  final Lesson lesson;

  const LessonHeader({super.key, required this.lesson});

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
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
          // Title and lock status
          Row(
            children: [
              // Lock icon
              Container(
                padding: const EdgeInsets.all(8),
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
                  size: 20,
                ),
              ),
              Dimensions.widthMedium,
              // Title
              Expanded(
                child: Text(
                  lesson.title ?? intl.undefined,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
          Dimensions.heightMedium,
          // Creation date
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: !AppTheme.islight
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
              Dimensions.widthSmall,
              Text(
                'Créé le ${_formatDate(lesson.createdAt ?? DateTime.now())}',
                style: TextStyle(
                  fontSize: 14,
                  color: !AppTheme.islight
                      ? Colors.grey.shade400
                      : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          if (lesson.updatedAt != null &&
              lesson.updatedAt!.isAfter(lesson.createdAt ?? DateTime.now()))
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.update,
                    size: 16,
                    color: !AppTheme.islight
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                  Dimensions.widthSmall,
                  Text(
                    'Mis à jour le ${_formatDate(lesson.updatedAt ?? DateTime.now())}',
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
        ],
      ),
    );
  }
}
