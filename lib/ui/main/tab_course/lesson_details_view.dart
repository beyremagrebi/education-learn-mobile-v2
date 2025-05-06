import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';
import 'package:studiffy/ui/main/tab_course/lesson_details_view_model.dart';
import 'package:studiffy/ui/main/tab_course/widgets/details/lesson_description_section.dart';
import 'package:studiffy/utils/widgets/async_widgets/async_model_list_builder.dart';

import '../../../utils/widgets/background_image_safe_area.dart';
import 'widgets/details/lesson_chapters_section.dart';
import 'widgets/details/lesson_header.dart';
import 'widgets/details/lesson_instructor_section.dart';
import 'widgets/details/lesson_meeting_section.dart';
import 'widgets/details/lesson_quiz_section.dart';
import 'widgets/details/lesson_subject_section.dart';

class LessonDetailsView extends StatelessWidget {
  final Lesson lesson;

  const LessonDetailsView({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LessonDetailsViewModel(context, lesson: lesson),
      child: Consumer<LessonDetailsViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: Text(intl.lesson),
          ),
          body: BackgroundImageSafeArea(
            svgAsset: Assets.bgMain,
            child: SingleChildScrollView(
              padding: Dimensions.paddingMedium,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LessonHeader(lesson: lesson),
                  Dimensions.heightHuge,
                  if (lesson.description.isNotEmptyAndNotNull) ...[
                    LessonDescriptionSection(
                      isExpanded: viewModel.isExpanded,
                      lesson: lesson,
                      onToggleExpand: viewModel.toggleExpanded,
                    ),
                    Dimensions.heightHuge,
                  ],
                  if (lesson.chapters.isNotEmptyAndNotNull) ...[
                    LessonChaptersSection(lesson: lesson),
                    Dimensions.heightHuge,
                  ],
                  AsyncModelListBuilder(
                    viewModel: viewModel,
                    modelList: viewModel.quizzes,
                    hideIfEmpty: viewModel.quizzes.isEmptyOrNull,
                    builder: (quizzes) => Column(
                      children: [
                        LessonQuizzesSection(
                          quizzes: quizzes,
                        ),
                        Dimensions.heightHuge
                      ],
                    ),
                  ),
                  if (lesson.meetCode != null) ...[
                    LessonMeetingSection(lesson: lesson),
                    Dimensions.heightHuge,
                  ],
                  LessonInstructorSection(lesson: lesson),
                  Dimensions.heightHuge,
                  if (lesson.subject != null) ...[
                    LessonSubjectSection(lesson: lesson),
                    Dimensions.heightHuge,
                  ],
                  // LessonActionButtons(lesson: lesson),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
