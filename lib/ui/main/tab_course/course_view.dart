import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_course/course_tab_view_model.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_builder.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/custum_input_field.dart';
import 'package:studiffy/utils/widgets/shimmer/shimmer_text.dart';

import '../../../utils/widgets/async_widgets/async_model_list_view_builder.dart';
import 'widgets/animated_class_selector.dart';
import 'widgets/lesson_card.dart';
import 'widgets/shimmer_lesson_card.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseTabViewModel(context),
      child: Consumer<CourseTabViewModel>(
        builder: (context, viewModel, child) => BackgroundImageSafeArea(
          svgAsset: Assets.bgMain,
          child: Padding(
            padding: Dimensions.paddingMedium,
            child: Column(
              children: [
                AsyncModelListBuilder(
                  viewModel: viewModel,
                  modelList: viewModel.classes,
                  loadingWidget: const ShimmerText.rectangular(
                    height: 30,
                    width: 150,
                  ),
                  builder: (classes) => AnimatedClassSelector(
                    currentClassName: viewModel.currentClass,
                    availableClasses: classes,
                    subtitle: intl.select_class,
                    onClassChanged: viewModel.changeClasse,
                    textColor: Theme.of(context).colorScheme.onSurface,
                    accentColor: Theme.of(context).primaryColor,
                  ),
                ),
                Dimensions.heightLarge,
                Visibility(
                  visible: viewModel.lessonList.isNotEmptyAndNotNull,
                  child: CustomInputField(
                    hintText: intl.searchHint,
                    prefixIcon: Icons.search,
                  ),
                ),
                Dimensions.heightLarge,
                Expanded(
                  child: AsyncModelListViewBuilder(
                    viewModel: viewModel,
                    modelList: viewModel.lessonList,
                    hideIfEmpy: viewModel.classes.isEmptyOrNull,
                    refreshFunction: viewModel.loadLesson,
                    loadingShimmer: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          const LessonCardShimmer(),
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
        ),
      ),
    );
  }
}
