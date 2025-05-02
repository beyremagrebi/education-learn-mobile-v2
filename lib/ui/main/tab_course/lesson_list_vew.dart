import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_course/lesson_list_view_model.dart';
import 'package:studiffy/ui/main/tab_course/widgets/lesson_card.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_view_builder.dart';
import 'package:studiffy/utils/widgets/custum_input_field.dart';

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
            ),

            Dimensions.heightMedium,
            // Filter chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip(intl.filterAll, true),
                  _buildFilterChip(intl.filterUnlocked, false),
                  _buildFilterChip(intl.filterLocked, false),
                  _buildFilterChip(intl.filterWithQuiz, false),
                ],
              ),
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

  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          // Apply filter
        },
      ),
    );
  }
}
