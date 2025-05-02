import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/time_table/session.dart';

class TimeTableOptions {
  static void showSessionDetails(BuildContext context, Session session) {
    showModalBottomSheet(
      context: context,
      backgroundColor: !AppTheme.islight ? Colors.grey.shade900 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: !AppTheme.islight
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Subject
            Text(
              session.subject?.name ?? 'undefined',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: !AppTheme.islight ? Colors.white : Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 16),
            // Time and day
            _buildDetailItem(
              icon: Icons.access_time,
              title: 'Horaire',
              value:
                  '${session.startTime} - ${session.endTime}, ${session.day}',
            ),
            const SizedBox(height: 12),
            // Instructor
            _buildDetailItem(
              icon: Icons.person,
              title: 'Instructeur',
              value:
                  '${session.instructor?.firstName} ${session.instructor?.lastName}',
            ),
            const SizedBox(height: 12),
            // Subject details
            _buildDetailItem(
              icon: Icons.school,
              title: 'Programme',
              value: session.subject?.name ?? 'Undefined',
            ),
            const SizedBox(height: 24),
            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.notifications_active,
                  label: 'Rappel',
                  onTap: () {
                    Navigator.pop(context);
                    // Set reminder
                  },
                ),
                _buildActionButton(
                  icon: Icons.message,
                  label: 'Message',
                  onTap: () {
                    Navigator.pop(context);
                    // Message instructor
                  },
                ),
                _buildActionButton(
                  icon: Icons.calendar_today,
                  label: 'Calendrier',
                  onTap: () {
                    Navigator.pop(context);
                    // Add to calendar
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color:
              !AppTheme.islight ? Colors.grey.shade400 : Colors.grey.shade600,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: !AppTheme.islight
                      ? Colors.grey.shade400
                      : Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(
              icon,
              color: !AppTheme.islight
                  ? Colors.blue.shade400
                  : Colors.blue.shade600,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: !AppTheme.islight
                    ? Colors.grey.shade300
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
