import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../../../core/localization/loalisation.dart';

class LessonMeetingSection extends StatelessWidget {
  final Lesson lesson;

  const LessonMeetingSection({super.key, required this.lesson});

  void _copyToClipboard(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code de réunion copié dans le presse-papiers'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _joinMeeting(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Connexion à la réunion: ${lesson.meetCode}'),
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
                Icons.videocam,
                size: 20,
                color: !AppTheme.islight
                    ? Colors.red.shade300
                    : Colors.red.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'Réunion virtuelle',
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
          // Meeting code
          Row(
            children: [
              Icon(
                Icons.code,
                size: 16,
                color: !AppTheme.islight
                    ? Colors.grey.shade400
                    : Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                'Code: ',
                style: TextStyle(
                  fontSize: 16,
                  color: !AppTheme.islight
                      ? Colors.grey.shade300
                      : Colors.grey.shade700,
                ),
              ),
              Text(
                lesson.meetCode ?? intl.undefined,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
              const Spacer(),
              // Copy button
              IconButton(
                icon: Icon(
                  Icons.copy,
                  color: !AppTheme.islight
                      ? Colors.blue.shade300
                      : Colors.blue.shade700,
                  size: 20,
                ),
                onPressed: () => _copyToClipboard(
                    lesson.meetCode ?? intl.undefined, context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Join button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _joinMeeting(context),
              icon: const Icon(Icons.video_call),
              label: const Text('Rejoindre la réunion'),
              style: ElevatedButton.styleFrom(
                backgroundColor: !AppTheme.islight
                    ? Colors.red.shade700
                    : Colors.red.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
