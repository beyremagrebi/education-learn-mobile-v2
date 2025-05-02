import 'package:studiffy/core/api/services/training_center/class_services.dart';
import 'package:studiffy/models/training_center/class/class.dart';

import '../../../../models/global/user/user.dart';

class SessionRoleManager {
  static Future<Class?> handleStudent(User user) async {
    if (user.classe != null) {
      final classId = user.classe?.id;
      final classResponse = await ClassServices.shared.getById(classId);
      if (classResponse.status) {
        final classValue = classResponse.resolveSingle(Class.fromMap);
        return classValue;
      }
    }
    return null;
  }
}
