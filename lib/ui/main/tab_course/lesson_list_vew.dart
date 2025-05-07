import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/extensions/filter_extensions.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_course/lesson_list_view_model.dart';
import 'package:studiffy/ui/main/tab_course/widgets/lesson_card.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_view_builder.dart';
import 'package:studiffy/utils/widgets/custum_input_field.dart';

import '../../../core/enums/filter_enums.dart';
import '../../../utils/widgets/base/filter_ship_bar.dart';
import 'widgets/shimmer_lesson_card.dart';

class LessonListVew extends StatelessWidget {
  final String? classId;
  const LessonListVew({
    required this.classId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LessonListViewModel(context, classId: classId),
      child: Consumer<LessonListViewModel>(
        builder: (context, viewModel, child) => Column(
          children: [
            // Search bar
            CustomInputField(
              hintText: intl.searchHint,
              prefixIcon: Icons.search,
              onChanged: (value) => viewModel.updateSearchQuery(value),
            ),

            Dimensions.heightMedium,
            // Filter chips
            FilterChipBar<LessonFilter>(
              filters: LessonFilter.values,
              viewModel: viewModel,
              getLabel: (filter) => filter.getLabel(context),
            ),

            Dimensions.heightMedium,

            // Lessons list
            Expanded(
              child: AsyncModelListViewBuilder(
                viewModel: viewModel,
                modelList: viewModel.filteredLessons,
                refreshFunction: viewModel.loadData,
                loadingShimmer: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => const LessonCardShimmer(),
                  itemCount: 5,
                ),
                builder: (lesson, index) {
                  return LessonCard(
                    lesson: lesson,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
