import 'package:studiffy/core/api/api_response.dart';
import 'package:studiffy/core/api/services/base_service.dart';

import 'package:studiffy/models/training_center/subject.dart';

import 'package:studiffy/utils/app/session/session_manager.dart';

import '../../../config/env.dart';
import '../../api_service.dart';

class SubjectServices extends BaseService<Subject> {
  // SINGLETON ----------------------------------------------------------------

  static final SubjectServices _instance = SubjectServices._internal();

  static SubjectServices get shared => _instance;

  SubjectServices._internal();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get apiUrl => '$baseUrl/$institution';

  @override
  Subject Function(dynamic map) get fromMapFunction => Subject.fromMap;
  @override
  Future<ApiResponse<Subject>> getById(String? id) async {
    return await ApiService.call(
      url: '$apiUrl/get-one-subject/$id',
      httpMethod: HttpMethod.get,
      dataKey: 'subject',
    );
  }

  Future<ApiResponse<List<Subject>>> getAllSubjectByRole(
      String? classId) async {
    return await ApiService.call(
      url: '$apiUrl/subject-by-class/$classId/${SessionManager.user.id}',
      httpMethod: HttpMethod.get,
      dataKey: 'subject',
    );
  }
}
