import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/api/utils/to_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/global/facility.dart';
import 'package:studiffy/models/training_center/class/class.dart';
import 'package:studiffy/models/training_center/subject.dart';

class TrainingCenterConfig extends BaseModel {
  Facility? facility;
  String? enterpriseId;
  List<Subject>? subjects;
  List<Class>? classes;
  List<String>? attendances;
  List<String>? quizzes;
  List<String>? results;
  List<String>? projet;
  List<String>? sharedSubjects;

  TrainingCenterConfig({
    required super.id,
    this.facility,
    this.enterpriseId,
    this.subjects,
    this.classes,
    this.attendances,
    this.quizzes,
    this.results,
    this.projet,
    this.sharedSubjects,
  });

  TrainingCenterConfig.fromId(String? id) : super(id: id);

  factory TrainingCenterConfig.fromMap(map) {
    if (map is String) return TrainingCenterConfig.fromId(map);

    return TrainingCenterConfig(
      id: FromJson.string(map['_id']),
      facility: FromJson.model(map['facilityId'], Facility.fromMap),
      enterpriseId: FromJson.string(map['enterpriseId']),
      classes: FromJson.modelList(map['classes'], Class.fromMap),
      subjects: FromJson.modelList(map['subjects'], Subject.fromMap),
      attendances: FromJson.list(map['attendances']),
      projet: FromJson.list(map['projet']),
      quizzes: FromJson.list(map['quizzes']),
      results: FromJson.list(map['results']),
      sharedSubjects: FromJson.list(map['sharedSubjects']),
    );
  }

  @override
  Map<String, Object> toMap() {
    Map<String, Object> map = {};
    map.add('_id', id);
    map.add('facilityId', ToJson.model(facility));
    map.add('enterpriseId', enterpriseId);
    map.add('subjects', ToJson.modelList(subjects));
    map.add('classes', ToJson.modelList(classes));

    return map;
  }
}
