import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../models/training_center/lesson/quiz.dart';

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
