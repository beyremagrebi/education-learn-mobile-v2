import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/time_table/session.dart';

class WeeklySessionCard extends StatelessWidget {
  final Session session;
  final VoidCallback onTap;

  const WeeklySessionCard({
    super.key,
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = _getColorForSession(session.color);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: borderColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject
              Text(
                session.subject?.name ?? 'undefined',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color:
                      !AppTheme.islight ? Colors.white : Colors.grey.shade800,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              // Time
              Flexible(
                child: Text(
                  '${session.startTime} - ${session.endTime}',
                  style: TextStyle(
                    fontSize: 9,
                    color: !AppTheme.islight
                        ? Colors.grey.shade400
                        : Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              // Instructor
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorForSession(String? colorName) {
    switch (colorName) {
      case 'success':
        return Colors.green.shade600;
      case 'info':
        return Colors.blue.shade600;
      case 'warning':
        return Colors.orange.shade600;
      case 'danger':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}
