import 'package:studiffy/core/base/base_model.dart';
import 'package:studiffy/models/training_center/class/class.dart';
import 'package:studiffy/models/training_center/time_table/session.dart';

class TimeTable extends BaseModel {
  Class? classe;
  List<Session>? sessions;

  TimeTable({required super.id, this.classe, this.sessions});

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
