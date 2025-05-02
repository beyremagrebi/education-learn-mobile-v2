import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../models/training_center/lesson/quiz.dart';
import 'widgets/details/lesson_details_option.dart';

class LessonDetailsViewModel extends BaseViewModel {
  Lesson lesson;
  LessonDetailsViewModel(super.context, {required this.lesson}) {
    getQuizzes();
  }
  bool isExpanded = false;
  List<Quiz>? quizzes;

  void toggleExpanded() {
    isExpanded = !isExpanded;
    update();
  }

  void showOptionsMenu() {
    showLessonOptionsMenu(
      context,
      lesson: lesson,
      onShare: _shareLesson,
      onSave: _saveLesson,
      onDownload: _downloadAllMaterials,
      onReport: _reportIssue,
    );
  }

  void _shareLesson() {}

  void _saveLesson() {}

  void _downloadAllMaterials() {}

  void _reportIssue() {}

  void getQuizzes() {
    if (lesson.chapters.isNotEmptyAndNotNull) {
      quizzes = [];
      for (var chapters in lesson.chapters!) {
        quizzes?.addAll(
          chapters.quizzes ?? [],
        );
      }
    } else {
      quizzes = [];
    }
  }
}
