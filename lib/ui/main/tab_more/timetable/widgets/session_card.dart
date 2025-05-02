import 'package:flutter/material.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/models/training_center/time_table/session.dart';

class SessionCard extends StatelessWidget {
  final Session session;
  final VoidCallback onTap;

  const SessionCard({
    super.key,
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = !AppTheme.islight
        ? Colors.grey.shade900.withOpacity(0.5)
        : Colors.white;

    final Color borderColor = _getColorForSession(session.color);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: !AppTheme.islight
            ? null
            : [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          // Time and subject header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: borderColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                // Time
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: borderColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${session.startTime} - ${session.endTime}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !AppTheme.islight
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Subject
                Expanded(
                  child: Text(
                    session.subject?.name ?? 'Undefined',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: !AppTheme.islight
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Session details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Instructor
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: AppTheme.disabledColor,
                    ),
                    Dimensions.widthSmall,
                    Expanded(
                      child: Text(
                        '${session.instructor?.firstName} ${session.instructor?.lastName}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
                Dimensions.heightSmall,
                // Day
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppTheme.disabledColor,
                    ),
                    Dimensions.widthSmall,
                    Text(
                      session.day?.name ?? 'undefined',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    color: AppTheme.disabledColor,
                  ),
                  onPressed: onTap,
                  tooltip: 'Détails',
                ),
              ],
            ),
          ),
        ],
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
