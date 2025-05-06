import 'package:flutter/material.dart';
import 'package:studiffy/ui/main/tab_more/class/subjects/widgets/shimmer/shimmer_subject_card.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_view_builder.dart';
import 'package:studiffy/utils/widgets/custum_input_field.dart';

import '../../../../../core/localization/loalisation.dart';
import '../../../../../core/style/dimensions.dart';
import '../../../../../utils/color_utils.dart';
import '../class_view_model.dart';
import 'widgets/subject_card.dart';

class SubjectView extends StatelessWidget {
  final ClassViewModel viewModel;
  const SubjectView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        CustomInputField(
          hintText: intl.searchHint,
          prefixIcon: Icons.search,
        ),
        Dimensions.heightLarge,
        // Subjects list
        Expanded(
          child: AsyncModelListViewBuilder(
            viewModel: viewModel,
            modelList: viewModel.subjectList,
            refreshFunction: viewModel.loadSubjects,
            loadingShimmer: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) => const ShimmerSubjectCard(),
            ),
            builder: (subject, index) {
              return SubjectCard(
                subject: subject,
                iconColor:
                    ColorUtils.getSubjectColor(subject.name ?? intl.undefined),
              );
            },
          ),
        ),
      ],
    );
  }
}
