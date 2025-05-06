import 'package:flutter/material.dart';
import 'package:studiffy/models/global/study_material.dart';

import '../../../../../../../core/localization/loalisation.dart';
import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';
import '../resource_item.dart';

class ResourceSection extends StatefulWidget {
  final List<StudyMaterial> studyMaterials;
  const ResourceSection({super.key, required this.studyMaterials});

  @override
  State<ResourceSection> createState() => _ResourceSectionState();
}

class _ResourceSectionState extends State<ResourceSection> {
  static const int initialChapterCount = 3;
  bool _showAllMaterials = false;
  @override
  Widget build(BuildContext context) {
    final materials = widget.studyMaterials;
    final displayMaterials = _showAllMaterials
        ? materials
        : materials.take(initialChapterCount).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          intl.resources,
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
              ...displayMaterials.map(
                (material) => Column(
                  children: [
                    ResourceItem(
                      fileName: material.fileName ?? intl.undefined,
                      icon: material.icon,
                      title: material.displayName ?? intl.undefined,
                      subtitle: material.subtitle,
                    ),
                    const Divider(height: 24, color: Colors.grey),
                  ],
                ),
              ),
              if (materials.length > initialChapterCount && !_showAllMaterials)
                _buildShowMoreButton(context),
              if (_showAllMaterials && materials.length > initialChapterCount)
                InkWell(
                  onTap: () {
                    setState(() {
                      _showAllMaterials = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.expand_less,
                          color: !AppTheme.islight
                              ? Colors.blue.shade300
                              : Colors.blue.shade700,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          intl.showLess,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: !AppTheme.islight
                                ? Colors.blue.shade300
                                : Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShowMoreButton(BuildContext context) {
    final remainingCount = widget.studyMaterials.length - initialChapterCount;

    return InkWell(
      onTap: () {
        setState(() {
          _showAllMaterials = true;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              remainingCount > 5 ? Icons.view_list : Icons.expand_more,
              color: !AppTheme.islight
                  ? Colors.blue.shade300
                  : Colors.blue.shade700,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              remainingCount > 5
                  ? '${intl.viewAll} ${widget.studyMaterials.length} ${intl.studyMaterials}'
                  : '${intl.showMore} ($remainingCount ${intl.more})',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: !AppTheme.islight
                    ? Colors.blue.shade300
                    : Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
