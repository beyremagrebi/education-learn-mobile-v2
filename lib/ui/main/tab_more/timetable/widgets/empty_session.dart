import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

class EmptySession extends StatelessWidget {
  const EmptySession({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 64,
            color: AppTheme.disabledColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun cours ce jour',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
