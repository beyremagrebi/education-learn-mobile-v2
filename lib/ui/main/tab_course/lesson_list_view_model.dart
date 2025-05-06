import 'package:flutter/material.dart';
import 'package:studiffy/core/api/services/training_center/lesson_services.dart';
import 'package:studiffy/core/base/base_view_model.dart';

import '../../../models/training_center/lesson/lesson.dart';

class LessonListViewModel extends BaseViewModel {
  final String? classId;
  LessonListViewModel(super.context, {required this.classId}) {
    loadData();
  }

  List<Lesson>? lessonList;

  List<Lesson>? get filteredLessons => lessonList;

  Future<void> loadData() async {
    try {
      lessonList = null;
      await makeApiCall(
        fromMapFunction: Lesson.fromMap,
        apiCall: LessonServices.shared.getLessonByClass(classId),
        onSuccess: (data) {
          lessonList = data;
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
