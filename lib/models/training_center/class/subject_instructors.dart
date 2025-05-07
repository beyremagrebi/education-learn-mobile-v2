import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/training_center/subject.dart';

import '../../../core/api/utils/to_json.dart';
import '../../global/user/user.dart';

class SubjectInstructors extends BaseModel {
  Subject? subject;
  User? instructor;
  List<User>? blockedStudents;

  SubjectInstructors({
    required super.id,
    this.subject,
    this.instructor,
    this.blockedStudents,
  });

  SubjectInstructors.fromId(String? id) : super(id: id);

  factory SubjectInstructors.fromMap(map) {
    if (map is String) return SubjectInstructors.fromId(map);

    return SubjectInstructors(
      id: FromJson.string(map['_id']),
      subject: FromJson.model(map['subject'], Subject.fromMap),
      instructor: FromJson.model(map['instructor'], User.fromMap),
      blockedStudents: FromJson.modelList(map['blockedStudents'], User.fromMap),
    );
  }

  @override
  Map<String, Object> toMap() {
    final map = <String, Object>{};
    map.add('_id', id);
    map.add('subject', ToJson.model(subject));
    map.add('instructor', ToJson.model(instructor));
    map.add('blockedStudents', ToJson.modelList(blockedStudents));
    return map;
  }
}
