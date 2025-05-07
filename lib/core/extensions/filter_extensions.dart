import 'package:flutter/material.dart';

import '../enums/filter_enums.dart';
import '../localization/loalisation.dart';

extension LessonFilterExtension on LessonFilter {
  String getLabel(BuildContext context) {
    switch (this) {
      case LessonFilter.all:
        return intl.filterAll;
      case LessonFilter.unlocked:
        return intl.filterUnlocked;
      case LessonFilter.locked:
        return intl.filterLocked;
      case LessonFilter.withQuiz:
        return intl.filterWithQuiz;
    }
  }
}

extension ClassFilterExtension on ClassFilter {
  String getLabel(BuildContext context) {
    switch (this) {
      case ClassFilter.all:
        return intl.filterAll;
      case ClassFilter.moreFemale:
        return intl.femaleMajority;
      case ClassFilter.moreMale:
        return intl.maleMajority;
      case ClassFilter.moreInstructors:
        return intl.instructorLed;
      case ClassFilter.moreStudents:
        return intl.studentFocused;
    }
  }
}
