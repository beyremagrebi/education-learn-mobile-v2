import 'package:flutter/material.dart';
import 'package:studiffy/core/api/services/training_center/lesson_services.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';

import '../../../core/enums/filter_enums.dart';
import '../../../models/training_center/lesson/lesson.dart';
import '../../../utils/view_models/filter_view_model.dart';

class LessonListViewModel extends BaseViewModel
    implements FilterViewModel<LessonFilter> {
  final String? classId;
  LessonListViewModel(super.context, {required this.classId}) {
    loadData();
  }

  List<Lesson>? lessonList;

  final Set<LessonFilter> _selectedFilters = {};
  String _searchQuery = '';
  @override
  bool isFilterSelected(LessonFilter filter) {
    return _selectedFilters.contains(filter);
  }

  @override
  void toggleFilter(LessonFilter filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    update();
  }

  List<Lesson>? get filteredLessons {
    if (lessonList == null) return null;

    Iterable<Lesson> filtered = lessonList!;

    // Apply filters
    if (_selectedFilters.isNotEmpty &&
        !_selectedFilters.contains(LessonFilter.all)) {
      filtered = filtered.where((lesson) {
        if (_selectedFilters.contains(LessonFilter.unlocked) &&
            !(lesson.isLocked ?? false)) {
          return true;
        }
        if (_selectedFilters.contains(LessonFilter.locked) &&
            (lesson.isLocked ?? false)) {
          return true;
        }
        if (_selectedFilters.contains(LessonFilter.withQuiz) &&
            hasQuiz(lesson)) {
          return true;
        }
        return false;
      });
    }

    // Apply search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((lesson) =>
          (lesson.title ?? '').toLowerCase().contains(_searchQuery) ||
          (lesson.description ?? '').toLowerCase().contains(_searchQuery));
    }

    return filtered.toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase().trim();
    update();
  }

  bool hasQuiz(Lesson lesson) {
    if (lesson.chapters.isNotEmptyAndNotNull) {
      for (var chapter in lesson.chapters!) {
        if (chapter.quizzes != null && chapter.quizzes!.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  Set<LessonFilter> get selectedFilters => _selectedFilters;

  Future<void> loadData() async {
    try {
      lessonList = null;
      await makeApiCallPagination(
        fromMapFunction: Lesson.fromMap,
        apiCall: LessonServices.shared.getPaginationLessonWithFiltre(classId),
        onSuccess: (paginationData) {
          lessonList = paginationData?.data;
        },
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
