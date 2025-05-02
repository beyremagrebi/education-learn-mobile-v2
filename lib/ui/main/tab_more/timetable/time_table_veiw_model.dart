import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/models/training_center/time_table/session.dart';

import '../../../../core/enums/days.dart';
import '../../../../models/global/user/user.dart';
import '../../../../models/training_center/subject.dart';

class TimeTableVeiwModel extends BaseViewModel {
  TimeTableVeiwModel(super.context);

  bool isWeeklyView = true;
  List<Days> days = Days.values;
  final List<Session> listSessions = [
    Session(
      id: '1',
      startTime: '08:00',
      endTime: '09:30',
      day: Days.lundi,
      color: 'info',
      subject: Subject(
        id: '1',
        name: 'Mathématiques',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '2',
      startTime: '10:00',
      endTime: '11:30',
      day: Days.lundi,
      color: 'warning',
      subject: Subject(
        id: '2',
        name: 'Physique',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '3',
      startTime: '14:00',
      endTime: '15:30',
      day: Days.lundi,
      color: 'success',
      subject: Subject(
        id: '3',
        name: 'Informatique',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '4',
      startTime: '09:00',
      endTime: '10:30',
      day: Days.mardi,
      color: 'danger',
      subject: Subject(
        id: '4',
        name: 'Anglais',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '5',
      startTime: '11:00',
      endTime: '12:30',
      day: Days.mardi,
      color: 'info',
      subject: Subject(
        id: '1',
        name: 'Mathématiques',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '6',
      startTime: '08:30',
      endTime: '10:00',
      day: Days.mercredi,
      color: 'success',
      subject: Subject(
        id: '5',
        name: 'Chimie',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '7',
      startTime: '10:30',
      endTime: '12:00',
      day: Days.mercredi,
      color: 'success',
      subject: Subject(
        id: '3',
        name: 'Informatique',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '8',
      startTime: '09:00',
      endTime: '10:30',
      day: Days.jeudi,
      color: 'info',
      subject: Subject(
        id: '1',
        name: 'Mathématiques',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '9',
      startTime: '11:00',
      endTime: '12:30',
      day: Days.jeudi,
      color: 'warning',
      subject: Subject(
        id: '4',
        name: 'Anglais',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '10',
      startTime: '14:00',
      endTime: '17:00',
      day: Days.jeudi,
      color: 'danger',
      subject: Subject(
        id: '5',
        name: 'Chimie',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '11',
      startTime: '08:30',
      endTime: '10:00',
      day: Days.vendredi,
      color: 'warning',
      subject: Subject(
        id: '2',
        name: 'Physique',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
    Session(
      id: '12',
      startTime: '10:30',
      endTime: '12:00',
      day: Days.vendredi,
      color: 'success',
      subject: Subject(
        id: '3',
        name: 'Informatique',
      ),
      instructor: User(
        id: 'id',
        firstName: 'Prof. ',
        lastName: 'Johnson',
        imageFilename: null,
      ),
    ),
  ];

  List<Session> getMockSessionsForDay(Days day) {
    return listSessions.where((session) => session.day == day).toList();
  }

  Session? findSessionAtTime(Days day, int hour) {
    final sessions = getMockSessionsForDay(day);

    for (final session in sessions) {
      final startHour =
          int.parse(session.startTime?.split(':')[0] ?? 'Undefined');
      final endHour = int.parse(session.endTime?.split(':')[0] ?? 'Undefined');

      if (hour >= startHour && hour < endHour) {
        return session;
      }
    }

    return null;
  }

  void toggleWeeklyView() {
    isWeeklyView = !isWeeklyView;
    update();
  }
}
