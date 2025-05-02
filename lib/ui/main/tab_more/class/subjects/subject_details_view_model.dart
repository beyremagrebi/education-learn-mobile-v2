import 'package:flutter/material.dart';
import 'package:studiffy/core/api/services/training_center/lesson_services.dart';
import 'package:studiffy/core/api/services/training_center/subject_services.dart';
import 'package:studiffy/models/training_center/lesson/lesson.dart';

import '../../../../../core/base/base_view_model.dart';
import '../../../../../models/global/study_material.dart';
import '../../../../../models/training_center/subject.dart';

class SubjectDetailsViewModel extends BaseViewModel {
  final String? subjectId;
  SubjectDetailsViewModel(super.context, {required this.subjectId}) {
    loadData();
  }

  Subject? subject;
  List<Lesson>? lessons;

  Future<void> loadData() async {
    try {
      await makeApiCall(
        fromMapFunction: Subject.fromMap,
        apiCall: SubjectServices.shared.getById(subjectId),
        onSuccess: (data) async {
          subject = data;
          await loadLesson();
        },
      );
    } catch (err) {
      debugPrint(
        err.toString(),
      );
    }
  }

  Future<void> loadLesson() async {
    try {
      await makeApiCall(
        fromMapFunction: Lesson.fromMap,
        apiCall: LessonServices.shared.getLessonBySubject(subjectId),
        onSuccess: (data) {
          lessons = data;
          loadResourceBylesson();
        },
      );
    } catch (err) {
      debugPrint(
        err.toString(),
      );
    }
  }

  List<StudyMaterial>? resourceList;
  loadResourceBylesson() {
    if (lessons == null) return [];

    final allMaterials = <StudyMaterial>[];

    for (final lesson in lessons!) {
      if (lesson.chapters == null) continue;
      for (final chapter in lesson.chapters!) {
        allMaterials.addAll(chapter.studyMaterials ?? []);
      }
    }

    resourceList = allMaterials;
  }
}
