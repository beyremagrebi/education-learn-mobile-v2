import 'package:flutter/material.dart';
import 'package:studiffy/core/api/services/training_center/lesson_services.dart';
import 'package:studiffy/core/api/services/training_center/subject_services.dart';

import '../../../../../core/base/base_view_model.dart';
import '../../../../../models/global/study_material.dart';
import '../../../../../models/training_center/subject.dart';

class SubjectDetailsViewModel extends BaseViewModel {
  final String? subjectId;
  SubjectDetailsViewModel(super.context, {required this.subjectId}) {
    loadData();
  }

  Subject? subject;

  Future<void> loadData() async {
    try {
      await makeApiCall(
        fromMapFunction: Subject.fromMap,
        apiCall: SubjectServices.shared.getById(subjectId),
        onSuccess: (data) async {
          subject = data;
          await loadResource();
        },
      );
    } catch (err) {
      debugPrint(
        err.toString(),
      );
    }
  }

  Future<void> loadResource() async {
    try {
      await makeApiCall(
        fromMapFunction: StudyMaterial.fromMap,
        apiCall: LessonServices.shared.getResourceBySubject(subjectId),
        onSuccess: (data) {
          resourceList = data;
        },
      );
    } catch (err) {
      debugPrint(
        err.toString(),
      );
    }
  }

  List<StudyMaterial>? resourceList;
}
