import 'package:flutter/material.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import 'package:studiffy/ui/main/tab_more/class/class_view_model.dart';

import 'package:studiffy/utils/widgets/async_widgets/async_model_list_view_builder.dart';
import 'package:studiffy/utils/widgets/custum_input_field.dart';

import '../../../../../core/style/dimensions.dart';

import '../subjects/widgets/shimmer/shimmer_subject_card.dart';
import 'widget/student_card.dart';

class StudentsView extends StatelessWidget {
  final ClassViewModel viewModel;
  const StudentsView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          hintText: intl.searchHint,
          prefixIcon: Icons.search,
        ),
        Dimensions.heightLarge,
        Expanded(
          child: AsyncModelListViewBuilder(
            viewModel: viewModel,
            modelList: viewModel.studetns,
            refreshFunction: () => viewModel.loadStudents(),
            loadingShimmer: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => const ShimmerSubjectCard(),
            ),
            builder: (studentFind, index) => StudentCard(
              student: studentFind,
            ),
          ),
        ),
      ],
    );
  }
}
