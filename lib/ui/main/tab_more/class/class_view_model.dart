import 'package:flutter/material.dart';
import 'package:studiffy/core/api/services/training_center/class_services.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/models/training_center/class/class.dart';

import '../../../../core/api/services/training_center/subject_services.dart';
import '../../../../models/global/user/user.dart';
import '../../../../models/training_center/subject.dart';

class ClassViewModel extends BaseViewModel {
  final String? classId;
  Class? classe;
  List<User>? studetns;
  List<Subject>? subjectList;
  ClassViewModel(super.context, {required this.classId}) {
    loadClass(classId);
  }

  Future<void> loadClass(String? id) async {
    try {
      await makeApiCall(
        fromMapFunction: Class.fromMap,
        apiCall: ClassServices.shared.getById(classId),
        onSuccess: (classeData) async {
          classe = classeData;
          await loadStudents();
          await loadSubjects();
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> loadStudents() async {
    try {
      await makeApiCall(
        fromMapFunction: User.fromMap,
        apiCall: ClassServices.shared.getStudentsByClass(classId),
        onSuccess: (stundentsData) {
          studetns = stundentsData;
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> loadSubjects() async {
    try {
      await makeApiCall(
        fromMapFunction: Subject.fromMap,
        apiCall: SubjectServices.shared.getAllSubjectByRole(classId),
        onSuccess: (data) {
          subjectList = data;
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
