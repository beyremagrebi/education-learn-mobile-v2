import 'package:flutter/material.dart';
import 'package:studiffy/models/global/study_material.dart';

import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';
import '../resource_item.dart';

class ResourceSection extends StatelessWidget {
  final List<StudyMaterial> studyMaterials;
  const ResourceSection({super.key, required this.studyMaterials});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ressources',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        Dimensions.heightLarge,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.islight
                ? Colors.white38
                : Colors.grey.shade800.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              for (var i = 0; i < studyMaterials.length; i++) ...[
                ResourceItem(
                  icon: studyMaterials[i].icon,
                  title: studyMaterials[i].displayName ?? 'Sans nom',
                  subtitle: studyMaterials[i].subtitle,
                ),
                if (i != studyMaterials.length - 1)
                  const Divider(height: 24, color: Colors.grey),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
