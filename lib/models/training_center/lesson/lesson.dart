import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/models/training_center/class/class.dart';
import 'package:studiffy/models/training_center/lesson/chapter.dart';
import 'package:studiffy/models/training_center/subject.dart';

class Lesson extends BaseModel {
  String? title;
  String? description;
  List<Chapter>? chapters;
  Subject? subject;
  User? instructor;

  Class? classe;
  String? meetCode;
  bool? isLocked;

  DateTime? createdAt;
  DateTime? updatedAt;

  Lesson({
    required super.id,
    required this.title,
    this.description,
    required this.chapters,
    required this.subject,
    required this.instructor,
    required this.classe,
    this.meetCode,
    required this.isLocked,
    required this.createdAt,
    this.updatedAt,
  });

  Lesson.fromId(String? id) : super(id: id);

  factory Lesson.fromMap(map) {
    if (map is String) return Lesson.fromId(map);

    return Lesson(
      id: FromJson.string(map['_id']),
      title: FromJson.string(map['title']),
      description: FromJson.string(map['description']),
      chapters: FromJson.modelList(map['chapters'], Chapter.fromMap),
      subject: FromJson.model(map['subjectId'], Subject.fromMap),
      instructor: FromJson.model(map['creator'], User.fromMap),
      classe: FromJson.model(map['classeId'], Class.fromMap),
      isLocked: FromJson.boolean(map['isLocked']),
      createdAt: FromJson.dateTime(map['createdAt']),
    );
  }

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
