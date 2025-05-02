import 'package:studiffy/core/base/base_model.dart';

class Quiz extends BaseModel {
  String? title;
  int? questionCount;
  int? timeLimit;
  bool? isCompleted;

  Quiz({
    required super.id,
    required this.title,
    required this.questionCount,
    required this.timeLimit,
    required this.isCompleted,
  });

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
