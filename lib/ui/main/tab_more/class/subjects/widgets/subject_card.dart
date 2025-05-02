import 'package:flutter/material.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

import 'package:studiffy/ui/main/tab_more/class/subjects/subject_details_view.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../../../../../../models/training_center/subject.dart';
import 'instructor_item.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final Color iconColor;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.islight ? Colors.white60 : Colors.black12,
        borderRadius: Dimensions.mediumBorderRadius,
      ),
      child: ExpansionTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.book,
            color: Colors.white,
          ),
        ),
        title: Text(subject.name ?? intl.undefined,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
        subtitle: Text(
          '${intl.program}: ${subject.name}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade400,
                fontSize: 12,
              ),
        ),
        trailing: const Icon(
          Icons.expand_more,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${intl.instructors}:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
                Dimensions.heightSmall,
                if (subject.instructors.isNotEmptyAndNotNull) ...[
                  ...subject.instructors!.map(
                    (instructor) => InstructorItem(
                      name: '${instructor.firstName} ${instructor.lastName}',
                      imageUrl: instructor.imageFilename,
                    ),
                  ),
                  Dimensions.heightSmall,
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        navigateTo(
                          context,
                          SubjectDetailsView(
                            subjectId: subject.id,
                            iconColor: iconColor,
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.info_outline,
                        size: 16,
                        color: AppTheme.islight
                            ? Colors.blue.shade700
                            : Colors.white70,
                      ),
                      label: Text(intl.details),
                      style: Theme.of(context).textButtonTheme.style?.copyWith(
                            foregroundColor: WidgetStatePropertyAll(
                              AppTheme.islight
                                  ? Colors.blue.shade700
                                  : Colors.white70,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
