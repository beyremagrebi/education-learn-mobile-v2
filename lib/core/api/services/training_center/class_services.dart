import 'package:studiffy/core/api/services/base_service.dart';
import 'package:studiffy/core/config/env.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/models/training_center/class/class.dart';

import '../../api_response.dart';
import '../../api_service.dart';
import '../../errors/dialod_exception.dart';

class ClassServices extends BaseService<Class> {
  // SINGLETON ----------------------------------------------------------------

  static final ClassServices _instance = ClassServices._internal();

  static ClassServices get shared => _instance;

  ClassServices._internal();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get apiUrl => '$baseUrl/$institution';

  @override
  Class Function(dynamic map) get fromMapFunction => Class.fromMap;

  @override
  Future<ApiResponse<Class>> getById(String? id) async {
    if (id == null) throw DialogException('class Id is required');

    return await ApiService.call(
      url: '$apiUrl/get-classe/$id',
      httpMethod: HttpMethod.get,
      dataKey: endpoints.getByIdDataKey,
    );
  }

  Future<ApiResponse<List<User>>> getStudentsByClass(String? classId) async {
    if (classId == null) throw DialogException('class Id is required');

    return await ApiService.call(
      url: '$apiUrl/classes/$classId/students',
      httpMethod: HttpMethod.get,
      dataKey: 'students',
    );
  }

  Future<ApiResponse<List<Class>>> getClassesByRole() async {
    return await ApiService.call(
      url: '$apiUrl/classes/byRole/$scholarshipConfigId',
      httpMethod: HttpMethod.get,
    );
  }
}
