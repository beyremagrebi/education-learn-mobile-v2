import 'package:flutter/widgets.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';

import '../../../core/api/services/training_center/class_services.dart';
import '../../../core/api/services/training_center/lesson_services.dart';
import '../../../models/training_center/class/class.dart';
import '../../../models/training_center/lesson/lesson.dart';

class CourseTabViewModel extends BaseViewModel {
  CourseTabViewModel(super.context) {
    loadData();
  }
  List<Class>? classes;
  Class? currentClass;

  Future<void> changeClasse(Class newClass) async {
    currentClass = newClass;

    await loadLesson();
    update();
  }

  Future<void> loadData() async {
    classes = null;
    await makeApiCall(
      fromMapFunction: Class.fromMap,
      apiCall: ClassServices.shared.getClassesByRole(),
      onSuccess: (data) async {
        if (data.isNotEmptyAndNotNull) {
          data!
              .sort((a, b) => (b.startDate ?? '').compareTo(a.startDate ?? ''));
          currentClass = data.first;
        }
        classes = data;
        await loadLesson();
      },
    );
  }

  List<Lesson>? lessonList;

  List<Lesson>? get filteredLessons => lessonList;

  Future<void> loadLesson() async {
    try {
      lessonList = null;
      await makeApiCall(
        fromMapFunction: Lesson.fromMap,
        apiCall: LessonServices.shared.getLessonByClass(currentClass?.id),
        onSuccess: (data) {
          lessonList = data;
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
