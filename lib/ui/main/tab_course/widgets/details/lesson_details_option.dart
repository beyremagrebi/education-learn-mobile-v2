import 'package:flutter/material.dart';
import '../../../../../core/style/themes/app_theme.dart';
import '../../../../../models/training_center/lesson/lesson.dart';

void showLessonOptionsMenu(
  BuildContext context, {
  required Lesson lesson,
  required VoidCallback onShare,
  required VoidCallback onSave,
  required VoidCallback onDownload,
  required VoidCallback onReport,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: !AppTheme.islight ? Colors.grey.shade900 : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context,
            icon: Icons.share,
            label: 'Partager',
            onTap: onShare,
          ),
          _buildOption(
            context,
            icon: Icons.bookmark,
            label: 'Sauvegarder',
            onTap: onSave,
          ),
          _buildOption(
            context,
            icon: Icons.download,
            label: 'Télécharger tous les documents',
            onTap: onDownload,
          ),
          if (!(lesson.isLocked ?? false))
            _buildOption(
              context,
              icon: Icons.report,
              label: 'Signaler un problème',
              iconColor: Colors.red.shade400,
              textColor: Colors.red.shade400,
              onTap: onReport,
            ),
        ],
      ),
    ),
  );
}

Widget _buildOption(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  Color? iconColor,
  Color? textColor,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: iconColor ??
          (!AppTheme.islight ? Colors.grey.shade400 : Colors.grey.shade700),
    ),
    title: Text(
      label,
      style: TextStyle(
        color: textColor ??
            (!AppTheme.islight ? Colors.white : Colors.grey.shade800),
      ),
    ),
    onTap: () {
      Navigator.pop(context);
      onTap();
    },
  );
}
