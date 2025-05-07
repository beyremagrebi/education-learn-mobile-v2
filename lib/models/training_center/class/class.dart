import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/core/enums/gender.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/global/scholirty_config/training_center_config.dart';
import 'package:studiffy/models/training_center/class/subject_instructors.dart';

import '../../../core/api/utils/to_json.dart';
import '../../global/user/user.dart';

class Class extends BaseModel {
  String? name;
  String? startDate;
  String? endDate;
  TrainingCenterConfig? scholarityConfigId;
  List<User>? students;
  List<SubjectInstructors>? subjectsInstructors;

  Class({
    required super.id,
    this.name,
    this.startDate,
    this.endDate,
    this.scholarityConfigId,
    this.students,
    this.subjectsInstructors,
  });

  Class.fromId(String? id) : super(id: id);

  factory Class.fromMap(map) {
    if (map is String) return Class.fromId(map);

    return Class(
      id: FromJson.string(map['_id']),
      name: FromJson.string(map['name']),
      startDate: FromJson.string(map['startDate']),
      endDate: FromJson.string(map['endDate']),
      scholarityConfigId: FromJson.model(
          map['scholarityConfigId'], TrainingCenterConfig.fromMap),
      students: FromJson.modelList(map['students'], User.fromMap),
      subjectsInstructors: FromJson.modelList(
          map['subjects_instructors'], SubjectInstructors.fromMap),
    );
  }

  @override
  Map<String, Object> toMap() {
    final map = <String, Object>{};
    map.add('_id', id);
    map.add('name', name);
    map.add('startDate', startDate);
    map.add('endDate', endDate);
    map.add('scholarityConfigId', ToJson.model(scholarityConfigId));
    map.add('student', ToJson.modelList(students));
    map.add('subjects_instructors', ToJson.modelList(subjectsInstructors));
    return map;
  }

  int get maleStudentsCount =>
      students?.where((s) => s.gender == Gender.male).length ?? 0;
  int get femaleStudentsCount =>
      students?.where((s) => s.gender == Gender.female).length ?? 0;
  int get totalStudents => students?.length ?? 0;
  double get femaleRatio =>
      totalStudents > 0 ? femaleStudentsCount / totalStudents : 0;
  double get maleRatio =>
      totalStudents > 0 ? maleStudentsCount / totalStudents : 0;
  int get instructorCount => subjectsInstructors?.length ?? 0;
}
