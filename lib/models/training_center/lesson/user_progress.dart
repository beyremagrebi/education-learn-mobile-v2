import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/models/global/user/user.dart';

import 'chapter.dart';

class UserProgress extends BaseModel {
  User? user;
  Chapter? chapter;
  bool? isComplete;

  UserProgress({
    required super.id,
    required this.user,
    required this.isComplete,
    this.chapter,
  });

  UserProgress.fromId(String? id) : super(id: id);

  factory UserProgress.fromMap(map) {
    if (map is String) return UserProgress.fromId(map);
    return UserProgress(
      id: FromJson.string(map['_id']),
      user: FromJson.model(map['userId'], User.fromMap),
      isComplete: FromJson.boolean(map['isComplete']),
      chapter: FromJson.model(
        map['chapterId'],
        Chapter.fromMap,
      ),
    );
  }

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
