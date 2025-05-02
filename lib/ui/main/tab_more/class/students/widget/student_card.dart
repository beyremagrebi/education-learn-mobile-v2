import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

import '../../../../../../core/style/dimensions.dart';
import '../../../../../../models/global/user/user.dart';
import '../../../../../../utils/navigator_utils.dart';
import '../../../../../../utils/widgets/media/api_image_widget.dart';
import '../student_details_view.dart';

class StudentCard extends StatelessWidget {
  final User student;

  const StudentCard({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCardOfStudent(context);
  }

  Widget _buildCardOfStudent(BuildContext context) {
    return InkWell(
      onTap: () => navigateTo(
          context,
          StudentDetailsView(
            student: student,
          )),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.islight ? Colors.white60 : Colors.black12,
          borderRadius: Dimensions.mediumBorderRadius,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ApiImageWidget(
              imageFilename: student.imageFilename,
              isMen: student.isMen,
              width: 48,
              height: 48,
              hasImageViewer: true,
              fit: BoxFit.cover,
            ),
            Dimensions.widthMedium,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${student.firstName} ${student.firstName}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                  ),
                  Text(
                    '${student.email}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppTheme.disabledColor,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.navigate_next)
          ],
        ),
      ),
    );
  }
}
