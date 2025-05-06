import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../../../core/localization/loalisation.dart';
import '../../../../../utils/widgets/media/api_image_widget.dart';

class LessonInstructorSection extends StatelessWidget {
  final Lesson lesson;

  const LessonInstructorSection({super.key, required this.lesson});

  void _contactInstructor(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacter ${lesson.instructor?.firstName}'),
        duration: const Duration(seconds: 2),
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
                Icons.person,
                size: 20,
                color: !AppTheme.islight
                    ? Colors.amber.shade300
                    : Colors.amber.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                intl.instructor,
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
          // Instructor info
          Row(
            children: [
              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: !AppTheme.islight
                      ? Colors.grey.shade800
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: ApiImageWidget(
                  imageFilename: lesson.instructor?.imageFilename,
                  fit: BoxFit.cover,
                  width: 30,
                  height: 30,
                  hasImageViewer: true,
                  isMen: true,
                ),
              ),
              const SizedBox(width: 16),
              // Name and contact
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.instructor?.firstName ?? intl.undefined,
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
                      lesson.instructor?.email ?? intl.undefined,
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
              // Contact button
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: !AppTheme.islight
                      ? Colors.blue.shade300
                      : Colors.blue.shade700,
                ),
                onPressed: () => _contactInstructor(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
