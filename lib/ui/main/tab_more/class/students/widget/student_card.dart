import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

import '../../../../../../core/style/dimensions.dart';
import '../../../../../../models/global/user/user.dart';
import '../../../../../../utils/navigator_utils.dart';
import '../../../../../../utils/widgets/media/api_image_widget.dart';

class StudentGridCard extends StatelessWidget {
  final User student;

  const StudentGridCard({
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
          Scaffold(
            appBar: AppBar(),
          )),
      child: Container(
        margin: Dimensions.paddingMedium,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ApiImageWidget(
              imageFilename: student.imageFilename,
              isMen: student.isMen,
              width: 40,
              height: 40,
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
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                        ),
                  ),
                  Text(
                    '${student.email}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: AppTheme.disabledColor,
                          fontSize: 13,
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
