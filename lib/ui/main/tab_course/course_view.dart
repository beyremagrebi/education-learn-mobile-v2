import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/ui/main/tab_course/course_tab_view_model.dart';
import 'package:studiffy/ui/main/tab_course/lesson_list_vew.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_builder.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_builder.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/shimmer/shimmer_text.dart';

import 'widgets/animated_class_selector.dart';
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
                AsyncModelBuilder(
                  viewModel: viewModel,
                  model: viewModel.currentClass,
                  loadingWidget: Expanded(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          const LessonCardShimmer(),
                      itemCount: 5,
                    ),
                  ),
                  isEmpty: viewModel.currentClass == null,
                  builder: (classe) => Expanded(
                    child: LessonListVew(
                      key: ValueKey(classe.id),
                      classId: classe.id,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
