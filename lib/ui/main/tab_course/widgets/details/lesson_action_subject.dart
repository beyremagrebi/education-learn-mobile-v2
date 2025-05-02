import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

class LessonActionButtons extends StatelessWidget {
  final Lesson lesson;

  const LessonActionButtons({super.key, required this.lesson});

  void _takeNotes(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ouverture de l\'éditeur de notes'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _markAsComplete(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Leçon marquée comme terminée'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Notes button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _takeNotes(context),
            icon: const Icon(Icons.note_add),
            label: const Text('Prendre des notes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: !AppTheme.islight
                  ? Colors.blue.shade700
                  : Colors.blue.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Mark as complete button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _markAsComplete(context),
            icon: const Icon(Icons.check_circle),
            label: const Text('Marquer comme terminé'),
            style: ElevatedButton.styleFrom(
              backgroundColor: !AppTheme.islight
                  ? Colors.green.shade700
                  : Colors.green.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
