import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/media/material_view_file.dart';

import '../../../../../../core/style/dimensions.dart';

class ResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String fileName;

  const ResourceItem({
    super.key,
    required this.icon,
    required this.fileName,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return _buildResourceItem(
      context: context,
      icon: icon,
      title: title,
      subtitle: subtitle,
    );
  }

  Widget _buildResourceItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return InkWell(
      onTap: () => navigateTo(
        context,
        MaterialViewFile(
          displayName: title,
          fileName: fileName,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: Dimensions.paddingSmall,
            decoration: BoxDecoration(
              color: Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          Dimensions.widthLarge,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.disabledColor,
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
          const Icon(Icons.navigate_next, color: Colors.grey),
        ],
      ),
    );
  }
}
