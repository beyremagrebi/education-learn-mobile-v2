import 'package:flutter/material.dart';
import 'package:studiffy/models/global/user/user.dart';

import '../../../../../../../core/localization/loalisation.dart';
import '../../../../../../../core/style/dimensions.dart';
import '../../../../../../../core/style/themes/app_theme.dart';
import '../../../../../../../utils/widgets/media/api_image_widget.dart';

class InstructorSection extends StatelessWidget {
  final List<User> instructors;
  const InstructorSection({super.key, required this.instructors});

  @override
  Widget build(BuildContext context) {
    return _buildInstructorsSection(
      context,
      instructors,
    );
  }

  Widget _buildInstructorsSection(
      BuildContext context, List<User> instructors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          intl.instructors,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        Dimensions.heightLarge,
        Container(
          padding: Dimensions.paddingSmall,
          decoration: BoxDecoration(
            color: AppTheme.islight
                ? Colors.white38
                : Colors.grey.shade800.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: instructors
                .map((instructor) => _buildInstructorItem(context, instructor))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructorItem(BuildContext context, User instructor) {
    return Container(
      margin: Dimensions.paddingSmall,
      child: Row(
        children: [
          ApiImageWidget(
            imageFilename: instructor.imageFilename,
            width: 48,
            height: 48,
            isMen: true,
          ),
          Dimensions.widthLarge,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${instructor.firstName} ${instructor.lastName}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                ),
                Text(
                  '${instructor.role?.localized}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.disabledColor,
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mail_outline),
            onPressed: () {},
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
