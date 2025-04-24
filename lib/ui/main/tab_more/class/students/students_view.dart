import 'package:flutter/material.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';
import 'package:studiffy/utils/widgets/from/inputs/input_text.dart';

import '../../../../../core/style/dimensions.dart';
import '../../../../../utils/widgets/transparent_shadow_decoration.dart';
import 'widget/student_card.dart';

class StudentsView extends StatelessWidget {
  const StudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InputText(
            controller: TextEditingController(),
            label: intl.searchLabel,
            hint: intl.searchHint,
            suffixIcon: Icons.search,
          ),
          Dimensions.heightLarge,
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  bottom: Dimensions.screenHeight(context) * 0.1),
              padding: Dimensions.paddingMedium,
              decoration: TransparentShadowDecoration(
                  color: Theme.of(context).colorScheme.onSurface),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => StudentGridCard(
                  student: SessionManager.user,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
