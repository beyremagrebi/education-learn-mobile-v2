import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/core/enums/days.dart';
import 'package:studiffy/models/global/user/user.dart';

import '../subject.dart';

class Session extends BaseModel {
  String? startTime;
  String? endTime;
  Days? day;
  String? color;
  Subject? subject;
  User? instructor;

  Session({
    required super.id,
    this.subject,
    this.day,
    this.color,
    this.instructor,
    this.endTime,
    this.startTime,
  });

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
