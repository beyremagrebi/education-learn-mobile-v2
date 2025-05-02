import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/api/utils/to_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/core/extensions/extensions.dart';
import 'package:studiffy/models/global/scholirty_config/training_center_config.dart';

import '../global/user/user.dart';

class Subject extends BaseModel {
  String? name;
  List<User>? instructors;
  TrainingCenterConfig? scholarityConfigId;
  Subject({
    required super.id,
    this.name,
    this.instructors,
    this.scholarityConfigId,
  });
  Subject.fromId(String? id) : super(id: id);

  factory Subject.fromMap(map) {
    if (map is String) return Subject.fromId(map);

    return Subject(
      id: FromJson.string(map['_id']),
      name: FromJson.string(map['name']),
      instructors: FromJson.modelList(map['instructors'], User.fromMap),
      scholarityConfigId: FromJson.model(
          map['scholarityConfigId'], TrainingCenterConfig.fromMap),
    );
  }
  @override
  Map<String, Object> toMap() {
    final map = <String, Object>{};
    map.add('_id', id);
    map.add('name', name);
    map.add('instructors', ToJson.modelList(instructors));
    map.add('scholarityConfigId', ToJson.model(scholarityConfigId));
    return map;
  }
}
