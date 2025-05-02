import 'package:flutter/material.dart';

import '../../../../../../core/style/dimensions.dart';
import '../../../../../../core/style/themes/app_theme.dart';

class ScheduleItem extends StatelessWidget {
  final String day;
  final String time;
  final String room;

  const ScheduleItem({
    super.key,
    required this.day,
    required this.time,
    required this.room,
  });
  @override
  Widget build(BuildContext context) {
    return _buildScheduleItem(
      context: context,
      day: day,
      time: time,
      room: room,
    );
  }

  Widget _buildScheduleItem({
    required BuildContext context,
    required String day,
    required String time,
    required String room,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
        ),
        Dimensions.widthLarge,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                    ),
              ),
              Text(
                room,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.disabledColor,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
